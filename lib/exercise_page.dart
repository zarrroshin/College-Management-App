import 'package:flutter/material.dart';

class ExercisePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('صفحه تمرینا'), // Exercise Page
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        child: Text(
          'اینجا صفحه تمرینا است!', // This is the Exercise Page!
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
