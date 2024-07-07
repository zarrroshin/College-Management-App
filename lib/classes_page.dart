import 'package:flutter/material.dart';

class ClassesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('صفحه کلاسا'), // Classes Page
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        child: Text(
          'اینجا صفحه کلاسا است!', // This is the Classes Page!
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
