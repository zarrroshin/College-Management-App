import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to University App!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/profile'); // Navigate to ProfilePage
              },
              child: Text('مشاهده صفحه کاربری'), // View Profile
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/work'); // Navigate to WorkPage
              },
              child: Text('صفحه کارا'), // Work Page
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/news'); // Navigate to NewsPage
              },
              child: Text('صفحه خبرا'), // News Page
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/exercise'); // Navigate to ExercisePage
              },
              child: Text('صفحه تمرینا'), // Exercise Page
            ),
          ],
        ),
      ),
    );
  }
}
