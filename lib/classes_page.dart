import 'dart:convert';
import 'dart:io';

import 'package:ap_finalproject/userdataSession.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ClassesPage extends StatefulWidget {
  @override
  _ClassesPageState createState() => _ClassesPageState();
}

class _ClassesPageState extends State<ClassesPage> {
  String serverAddress = "172.20.115.46:8080";
  List<Map<String, dynamic>> classes = [
    {
      'courseId': '',
      'courseName': '',
      'professor': '',
      'students': [],
      'units': '',
      'topStudent': '',
      'remainingAssignments': '',
    },
  ];

  List<Map<String, dynamic>> offeredCourses = [
    {
      'courseId': '',
      'courseName': '',
      'professor': '',
      'students': [],
      'units': '',
      'topStudent': '',
      'remainingAssignments': '',
    },
  ];

  Future<void> fetchClassData() async {
    final userdataSession =
        Provider.of<UserdataSession>(context, listen: false);
    try {
      final response = await http.get(Uri.parse(
          'http://${serverAddress}/classesData?studentId=${userdataSession.studentId}'));

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        print('JSON Data: $jsonData');

        List<Map<String, dynamic>> newClasses = [];
        for (var course in jsonData['Courses']) {
          newClasses.add({
            'courseId': course['cpr_id'],
            'courseName': course['name'],
            'professor': course['professor'],
            'students': [], // Initialize the students list here
            'units': course['vahed'],
            'topStudent': '',
            'remainingAssignments': course['numofassign'],
          });
        }

        setState(() {
          offeredCourses = newClasses;
        });
        print('UI updated with fetched data');
      } else {
        print('Error fetching data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      if (e is SocketException) {
        print('Handling connection reset by peer...');
        // Optionally, retry the request
        await Future.delayed(Duration(seconds: 2)); // Delay before retrying
        await fetchClassData(); // Retry the fetch
      }
    }
  }

  Future<void> fetchStdClassData() async {
    final userdataSession =
        Provider.of<UserdataSession>(context, listen: false);
    try {
      final response = await http.get(Uri.parse(
          'http://${serverAddress}/stdClassData?studentId=${userdataSession.studentId}'));

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        print('JSON Data: $jsonData');

        List<Map<String, dynamic>> newClasses = [];
        for (var course in jsonData['Courses']) {
          newClasses.add({
            'courseId': course['cpr_id'],
            'courseName': course['name'],
            'professor': course['professor'],
            'students': [], // Initialize the students list here
            'units': course['vahed'],
            'topStudent': '',
            'remainingAssignments': course['numofassign'],
          });
        }

        setState(() {
          classes = newClasses;
        });
        print('UI updated with fetched data');
      } else {
        print('Error fetching data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      if (e is SocketException) {
        print('Handling connection reset by peer...');
        // Optionally, retry the request
        await Future.delayed(Duration(seconds: 2)); // Delay before retrying
        await fetchClassData(); // Retry the fetch
      }
    }
  }

  Future<void> addClassToServer(String courseId) async {
    final userdataSession =
        Provider.of<UserdataSession>(context, listen: false);
    try {
      final response = await http.get(Uri.parse(
          'http://${serverAddress}/addClassData?studentId=${userdataSession.studentId}&courseid=$courseId'));

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        print('JSON Data: $jsonData');
        print('UI updated with fetched data');
      } else {
        print('Error fetching data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      if (e is SocketException) {
        print('Handling connection reset by peer...');
        // Optionally, retry the request
        await Future.delayed(Duration(seconds: 2)); // Delay before retrying
        await fetchClassData(); // Retry the fetch
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchClassData();
    fetchStdClassData();
  }

  String newCourseId = '';
  String currentStudent = 'student3';

  void addClass(String courseId) {
    bool classExists = false;
    for (var cls in offeredCourses) {
      if (cls['courseId'] == courseId) {
        classExists = true;
        if (cls['students'] != null &&
            !cls['students'].contains(currentStudent)) {
          setState(() {
            cls['students'].add(currentStudent);
            classes.add(cls);
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('کلاس با موفقیت اضافه شد!'),
            backgroundColor: Colors.green,
          ));

          addClassToServer(
              courseId); // Call the future function to send data to server
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
            'کلاس ها',
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
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: Icon(Icons.class_,
                                    color: Colors.indigo, size: 40),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    classes[index]['courseName'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('استاد: ${classes[index]['professor']}',
                                  textAlign: TextAlign.right),
                              SizedBox(width: 8),
                              Icon(Icons.person, color: Colors.indigo),
                            ],
                          ),
                          SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('تعداد واحد: ${classes[index]['units']}',
                                  textAlign: TextAlign.right),
                              SizedBox(width: 8),
                              Icon(Icons.book, color: Colors.indigo),
                            ],
                          ),
                          SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                  'دانشجوی ممتاز: ${classes[index]['topStudent']}',
                                  textAlign: TextAlign.right),
                              SizedBox(width: 8),
                              Icon(Icons.star, color: Colors.indigo),
                            ],
                          ),
                          SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                  'تعداد تکالیف باقی‌مانده: ${classes[index]['remainingAssignments']}',
                                  textAlign: TextAlign.right),
                              SizedBox(width: 8),
                              Icon(Icons.assignment, color: Colors.indigo),
                            ],
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
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
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
