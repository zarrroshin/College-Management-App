import 'package:flutter/material.dart';

class WorkPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('صفحه کارا'), // Work Page
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        child: Text(
          'اینجا صفحه کارا است!', // This is the Work Page!
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
