import 'package:flutter/material.dart';

class ClassesPage extends StatefulWidget {
  @override
  _ClassesPageState createState() => _ClassesPageState();
}

class _ClassesPageState extends State<ClassesPage> {
  List<Map<String, dynamic>> classes = [
    {
      'courseId': 'CS101',
      'courseName': 'ساختمان داده',
      'professor': 'وحیدی اصل',
      'schedule': 'دوشنبه ها 8:00 - 11:00 ',
      'students': ['student1', 'student2']
    },
    {
      'courseId': 'MATH201',
      'courseName': 'ریاضی 2',
      'professor': 'بوالحسنی',
      'schedule': 'چهارشنبه ها 5:00 - 6:00',
      'students': ['student1']
    },
  ];

  String newCourseId = '';
  String currentStudent = 'student3';

  void addClass(String courseId) {
    bool classExists = false;
    for (var cls in classes) {
      if (cls['courseId'] == courseId) {
        classExists = true;
        if (!cls['students'].contains(currentStudent)) {
          setState(() {
            cls['students'].add(currentStudent);
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('کلاس با موفقیت اضافه شد!'),
            backgroundColor: Colors.green,
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('شما قبلاً در این کلاس ثبت نام کرده‌اید.'),
            backgroundColor: Colors.orange,
          ));
        }
        break;
      }
    }
    if (!classExists) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('کلاس یافت نشد.'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.bottomRight,
          child: Text(
            'صفحه کلاسا',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: classes.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16),
                      leading: Icon(Icons.class_, color: Colors.indigo),
                      title: Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          classes[index]['courseName'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(height: 8),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text('استاد: ${classes[index]['professor']}',
                                textAlign: TextAlign.right),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text('ساعت کلاسی: ${classes[index]['schedule']}',
                                textAlign: TextAlign.right),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: TextField(
                onChanged: (value) {
                  newCourseId = value;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'کد درس را وارد کنید                                          ',
                  prefixIcon: Icon(Icons.add),
                  filled: true,
                  fillColor: Colors.grey[200],
                  labelStyle: TextStyle(
                    color: Colors.black,
                  ),
                ),
                textAlign: TextAlign.right,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                addClass(newCourseId);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                child: Text('افزودن کلاس',
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
