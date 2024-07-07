import 'package:flutter/material.dart';
import 'profile.dart';
import 'work_page.dart';
import 'news_page.dart';
import 'exercise_page.dart';
import 'classes_page.dart';
import 'login.dart'; // Import the LoginPage file

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.bottomRight,
          child: Text(
            'صفحه اصلی',
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Navigation Buttons
              buildButton(context, 'صفحه کاربری', '/profile'),
              SizedBox(height: 10),
              buildButton(context, 'صفحه کارها', '/work'),
              SizedBox(height: 10),
              buildButton(context, 'صفحه خبرها', '/news'),
              SizedBox(height: 10),
              buildButton(context, 'صفحه تمرینات', '/exercise'),
              SizedBox(height: 10),
              buildButton(context, 'صفحه کلاس‌ها', '/classes'),
              SizedBox(height: 20),

              // Important Announcements
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          'آخرین دستاوردهای دانشگاه',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          'برگزاری مسابقه برنامه‌نویسی NEWBIES',
                          style: TextStyle(fontSize: 18),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Help and Support
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          'ارتباط با پشتیبانی',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      ListTile(
                        leading: Icon(Icons.info),
                        title: Text('تماس با پشتیبانی'),
                        subtitle: Text('برای کمک فنی'),
                        onTap: () {
                          // Implement contact IT support action
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.feedback),
                        title: Text('بازخورد'),
                        subtitle: Text('ارسال بازخورد شما'),
                        onTap: () {
                          // Implement feedback action
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButton(BuildContext context, String label, String route) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, route);
      },
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(16)),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontFamily: 'Roboto',
        ),
      ),
    );
  }
}
