import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class WorkPage extends StatefulWidget {
  @override
  _WorkPageState createState() => _WorkPageState();
}

class _WorkPageState extends State<WorkPage> {
  String serverAddress = "192.168.1.119:8080";
  List<Map<String, dynamic>> tasks = [];
  List<Map<String, dynamic>> completedTasks = [];

  @override
  void initState() {
    super.initState();
    fetchTasksData();
    fetchCompletedTasksData();
  }

  Future<void> fetchTasksData() async {
    try {
      final response = await http.get(Uri.parse('http://${serverAddress}/tasks'));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        List<Map<String, dynamic>> newTasks = [];
        for (var task in jsonData['tasks']) {
          newTasks.add({
            'title': task['title'],
            'dateTime': DateTime.parse(task['dateTime']),
          });
        }

        setState(() {
          tasks = newTasks;
        });
      } else {
        print('Error fetching data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      if (e is SocketException) {
        await Future.delayed(Duration(seconds: 2)); // Delay before retrying
        await fetchTasksData(); // Retry the fetch
      }
    }
  }

  Future<void> fetchCompletedTasksData() async {
    try {
      final response = await http.get(Uri.parse('http://${serverAddress}/completedTasks'));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        List<Map<String, dynamic>> newCompletedTasks = [];
        for (var task in jsonData['completedTasks']) {
          newCompletedTasks.add({
            'title': task['title'],
            'dateTime': DateTime.parse(task['dateTime']),
          });
        }

        setState(() {
          completedTasks = newCompletedTasks;
        });
      } else {
        print('Error fetching data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      if (e is SocketException) {
        await Future.delayed(Duration(seconds: 2)); // Delay before retrying
        await fetchCompletedTasksData(); // Retry the fetch
      }
    }
  }

  Future<void> addTaskToServer(String title, DateTime dateTime) async {
    try {
      final response = await http.post(
        Uri.parse('http://${serverAddress}/addTask'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'title': title,
          'dateTime': dateTime.toIso8601String(),
        }),
      );

      if (response.statusCode == 200) {
        fetchTasksData();
      } else {
        print('Error adding task: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      if (e is SocketException) {
        await Future.delayed(Duration(seconds: 2)); // Delay before retrying
        await addTaskToServer(title, dateTime); // Retry adding the task
      }
    }
  }

  Future<void> markTaskAsDoneOnServer(int index) async {
    try {
      final response = await http.post(
        Uri.parse('http://${serverAddress}/markTaskAsDone'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'title': tasks[index]['title'],
        }),
      );

      if (response.statusCode == 200) {
        fetchTasksData();
        fetchCompletedTasksData();
      } else {
        print('Error marking task as done: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      if (e is SocketException) {
        await Future.delayed(Duration(seconds: 2)); // Delay before retrying
        await markTaskAsDoneOnServer(index); // Retry marking the task as done
      }
    }
  }

  void addTask(String title, DateTime dateTime) {
    addTaskToServer(title, dateTime);
  }

  void markTaskAsDone(int index) {
    setState(() {
      completedTasks.add(tasks[index]);
      tasks.removeAt(index);
    });
    markTaskAsDoneOnServer(index);
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
    // Optionally send a request to delete the task from the server
  }

  Future<void> _editTask(int index) async {
    String taskTitle = tasks[index]['title'];
    DateTime taskDateTime = tasks[index]['dateTime'];

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('ویرایش کار'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  taskTitle = value;
                },
                controller: TextEditingController(text: taskTitle),
                decoration: InputDecoration(hintText: "عنوان کار"),
              ),
              TextButton(
                child: Text('انتخاب تاریخ'),
                onPressed: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: taskDateTime,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null) {
                    setState(() {
                      taskDateTime = picked;
                    });
                  }
                },
              ),
              TextButton(
                child: Text('انتخاب زمان'),
                onPressed: () async {
                  TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(taskDateTime),
                  );
                  if (picked != null) {
                    setState(() {
                      taskDateTime = DateTime(
                          taskDateTime.year,
                          taskDateTime.month,
                          taskDateTime.day,
                          picked.hour,
                          picked.minute);
                    });
                  }
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('لغو'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('ذخیره'),
              onPressed: () {
                setState(() {
                  tasks[index] = {'title': taskTitle, 'dateTime': taskDateTime};
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _displayAddTaskDialog(BuildContext context) async {
    String taskTitle = '';
    DateTime taskDateTime = DateTime.now();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('افزودن کار جدید'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  taskTitle = value;
                },
                decoration: InputDecoration(hintText: "عنوان کار"),
              ),
              TextButton(
                child: Text('انتخاب تاریخ'),
                onPressed: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: taskDateTime,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null) {
                    setState(() {
                      taskDateTime = picked;
                    });
                  }
                },
              ),
              TextButton(
                child: Text('انتخاب زمان'),
                onPressed: () async {
                  TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(taskDateTime),
                  );
                  if (picked != null) {
                    setState(() {
                      taskDateTime = DateTime(
                          taskDateTime.year,
                          taskDateTime.month,
                          taskDateTime.day,
                          picked.hour,
                          picked.minute);
                    });
                  }
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('لغو'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('افزودن'),
              onPressed: () {
                addTask(taskTitle, taskDateTime);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.bottomRight,
          child: Text(
            'کارها',
            style: TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.bold,
              fontFamily: 'Vazir',
            ),
          ),
        ),
        backgroundColor: Color(0xff4caf50),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(tasks[index]['title']),
                  subtitle: Text(tasks[index]['dateTime'].toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.check),
                        onPressed: () {
                          markTaskAsDone(index);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          _editTask(index);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          deleteTask(index);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Text(
            'کارهای انجام شده',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: completedTasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(completedTasks[index]['title']),
                  subtitle: Text(completedTasks[index]['dateTime'].toString()),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _displayAddTaskDialog(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xff4caf50),
      ),
    );
  }
}
