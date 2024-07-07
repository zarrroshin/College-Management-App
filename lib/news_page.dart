import 'package:flutter/material.dart';

class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('صفحه خبرا'), // News Page
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        child: Text(
          'اینجا صفحه خبرا است!', // This is the News Page!
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
