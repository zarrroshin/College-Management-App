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

  List<Map<String, dynamic>> offeredCourses = [
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
    {
      'courseId': 'PHYS301',
      'courseName': 'فیزیک 1',
      'professor': 'دکتر جلالی',
      'schedule': 'سه‌شنبه‌ها 9:00 - 10:30',
      'students': []
    },
    {
      'courseId': 'CHEM101',
      'courseName': 'شیمی عمومی',
      'professor': 'دکتر کاظمی',
      'schedule': 'پنجشنبه‌ها 11:00 - 12:30',
      'students': []
    },
  ];

  String newCourseId = '';
  String currentStudent = 'student3';

  void addClass(String courseId) {
    bool classExists = false;
    for (var cls in offeredCourses) {
      if (cls['courseId'] == courseId) {
        classExists = true;
        if (!cls['students'].contains(currentStudent)) {
          setState(() {
            cls['students'].add(currentStudent);
            classes.add(cls);
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

  void showAvailableCourses() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('دروس ارایه شده'),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: offeredCourses.length,
              itemBuilder: (context, index) {
                bool isEnrolled = classes.any((cls) =>
                cls['courseId'] == offeredCourses[index]['courseId'] &&
                    cls['students'].contains(currentStudent));
                return Visibility(
                  visible: !isEnrolled,
                  child: ListTile(
                    title: Text(offeredCourses[index]['courseName']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('کد درس: ${offeredCourses[index]['courseId']}'),
                        Text('استاد: ${offeredCourses[index]['professor']}'),
                      ],
                    ),
                  ),
                );
              },
            ),
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
              child: Row(
                children: [
                  Expanded(
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextFormField(
                        onChanged: (value) {
                          newCourseId = value;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'کد درس را وارد کنید',
                          prefixIcon: Icon(Icons.add),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.list),
                    onPressed: showAvailableCourses,
                    tooltip: 'نمایش دروس ارایه شده',
                  ),
                ],
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
