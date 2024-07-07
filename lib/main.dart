import 'package:flutter/material.dart';
import 'login.dart';
import 'signup.dart';
import 'home.dart';
import 'profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'University App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login', // Set initial route to LoginPage
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/home': (context) => HomePage(),
        '/profile': (context) => ProfilePage(), // Add route for ProfilePage
      },
    );
  }
}
