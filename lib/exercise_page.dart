import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting

class ExercisePage extends StatefulWidget {
  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  DateTime selectedDate = DateTime.now();
  List<Map<String, dynamic>> courses = [
    {
      'courseId': 'CS101',
      'courseName': 'ساختمان داده',
      'exercises': [
        {
          'title': 'تمرین 1',
          'dueDate': DateTime.now().add(Duration(days: 1)),
          'estimatedTime': '2 hours',
          'description': 'پیاده‌سازی لیست پیوندی',
          'completed': false,
          'grade': 0
        },
        {
          'title': 'تمرین 2',
          'dueDate': DateTime.now().subtract(Duration(days: 1)),
          'estimatedTime': '3 hours',
          'description': 'پیاده‌سازی درخت دودویی',
          'completed': true,
          'grade': 90
        },
      ],
    },
    {
      'courseId': 'MATH201',
      'courseName': 'ریاضی 2',
      'exercises': [
        {
          'title': 'تمرین 1',
          'dueDate': DateTime.now().add(Duration(days: 3)),
          'estimatedTime': '1.5 hours',
          'description': 'حل انتگرال‌ها',
          'completed': false,
          'grade': 0
        },
        {
          'title': 'تمرین 2',
          'dueDate': DateTime.now().add(Duration(days: 2)),
          'estimatedTime': '2 hours',
          'description': 'حل معادلات دیفرانسیل',
          'completed': false,
          'grade': 0
        },
      ],
    },
  ];

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020, 1, 1),
      lastDate: DateTime(2100, 12, 31),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _showExerciseDetails(Map<String, dynamic> exercise) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String estimatedTime = exercise['estimatedTime'];
        String description = exercise['description'];

        return AlertDialog(
          title: Align(alignment: Alignment.topRight,child:Text(exercise['title']),),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [Align(alignment: Alignment.topRight,child:
              Text('روز باقی مانده تا ددلاین: ${exercise['dueDate'].difference(DateTime.now()).inDays}')),
              SizedBox(height: 8),

              Align(alignment: Alignment.topRight,child:Text('نمره: ${exercise['grade']}'),),
              SizedBox(height: 8),
              TextField(
                controller: TextEditingController(text: estimatedTime),
                readOnly: true, // Make the TextField non-editable
                decoration: InputDecoration(
                  labelText: 'مدت زمان تخمینی ',
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: TextEditingController(text: description),
                readOnly: true, // Make the TextField non-editable
                decoration: InputDecoration(
                  labelText: 'توضیحات                                            ',
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('بستن'),
              onPressed: () {
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
        title:Align(
          alignment: Alignment.bottomRight,
          child: Text('تمرین ها',style: TextStyle(color: Colors.white, fontSize: 23,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',),),), // Exercise Page
        backgroundColor: Colors.indigo,
      ),
      body: ListView.builder(
        itemCount: courses.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 5,
            child: ExpansionTile(
              title: Text(
                courses[index]['courseName'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textAlign: TextAlign.right,
              ),
              children: [
                ...courses[index]['exercises'].map<Widget>((exercise) {
                  bool isOverdue = exercise['dueDate'].isBefore(DateTime.now());
                  bool isCompleted = exercise['completed'];
                  return ListTile(
                    title: Text(exercise['title']),
                    subtitle: Text(
                      'تاریخ تحویل: ${DateFormat('yyyy-MM-dd').format(exercise['dueDate'])}',
                    ),
                    trailing: Icon(
                      isCompleted ? Icons.check_circle : isOverdue ? Icons.error : Icons.circle,
                      color: isCompleted ? Colors.green : isOverdue ? Colors.red : Colors.orange,
                    ),
                    onTap: () => _showExerciseDetails(exercise),
                  );
                }).toList(),
              ],
            ),
          );
        },
      ),
    );
  }
}