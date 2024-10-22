import 'package:flutter/material.dart';

class WorkPage extends StatefulWidget {
  @override
  _WorkPageState createState() => _WorkPageState();
}

class _WorkPageState extends State<WorkPage> {
  List<Map<String, dynamic>> tasks = [];
  List<Map<String, dynamic>> completedTasks = [];

  @override
  void initState() {
    super.initState();

    // Initialize tasks with predefined values
    tasks = [
      {'title': 'AP_Project', 'dateTime': DateTime.now()},
      {'title': 'checking github', 'dateTime': DateTime.now()},
    ];
  }

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
                      taskDateTime = DateTime(taskDateTime.year, taskDateTime.month, taskDateTime.day, picked.hour, picked.minute);
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
              fontFamily: 'Roboto',
            ),
          ),
        ),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              color: Colors.white,
              child: tasks.isEmpty
                  ? Center(child: Text('هیچ کار پیش رو وجود ندارد'))
                  : ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    elevation: 3,
                    child: ListTile(
                      title: Text(tasks[index]['title']),
                      subtitle: Text(tasks[index]['dateTime'].toString()),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _editTask(index),
                          ),
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
                    ),
                  );
                },
              ),
            ),
          ),
          Divider(),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.indigo,
                borderRadius: BorderRadius.circular(22), // Adjust the radius as needed
              ),
              child: Text(
                '  کارهای انجام شده   ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),

          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              color: Colors.white,
              child: completedTasks.isEmpty
                  ? Center(child: Text('هیچ کار انجام شده‌ای وجود ندارد'))
                  : ListView.builder(
                itemCount: completedTasks.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    elevation: 3,
                    child: ListTile(
                      title: Text(completedTasks[index]['title']),
                      subtitle: Text(completedTasks[index]['dateTime'].toString()),
                    ),
                  );
                },
              ),
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
                      taskDateTime = DateTime(taskDateTime.year, taskDateTime.month, taskDateTime.day, picked.hour, picked.minute);
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
}
