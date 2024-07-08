import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'dart:async';


class WorkPage extends StatefulWidget {
  @override
  _WorkPageState createState() => _WorkPageState();
}

class _WorkPageState extends State<WorkPage> {
  List<Map<String, dynamic>> tasks = [];
  List<Map<String, dynamic>> completedTasks = [];

  void addTask(String title, DateTime dateTime) {
    setState(() {
      tasks.add({'title': title, 'dateTime': dateTime});
    });
  }

  void markTaskAsDone(int index) {
    setState(() {
      completedTasks.add(tasks[index]);
      tasks.removeAt(index);
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('صفحه کارا'),
        backgroundColor: Colors.indigo,
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
                        icon: Icon(Icons.check, color: Colors.green),
                        onPressed: () => markTaskAsDone(index),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => deleteTask(index),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Divider(),
          Text(
            'کارهای انجام شده:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
        onPressed: () => _displayAddTaskDialog(context),
        child: Icon(Icons.add),
        backgroundColor: Colors.indigo,
      ),
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
              DateTimePicker(
                type: DateTimePickerType.dateTimeSeparate,
                dateMask: 'd MMM, yyyy',
                initialValue: taskDateTime.toString(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                icon: Icon(Icons.event),
                dateLabelText: 'تاریخ',
                timeLabelText: "ساعت",
                onChanged: (val) => taskDateTime = DateTime.parse(val),
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
}



