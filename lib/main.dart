import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login.dart';
import 'signup.dart';
import 'home.dart';
import 'profile.dart';
import 'work_page.dart';
import 'news_page.dart';
import 'exercise_page.dart';
import 'classes_page.dart';
import 'userdataSession.dart'; // Import the UserdataSession class

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserdataSession(), // Create an instance of UserdataSession
      child: MyApp(),
    ),
  );
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
        '/profile': (context) => ProfilePage(),
        '/work': (context) => WorkPage(),
        '/news': (context) => NewsPage(),
        '/exercise': (context) => ExercisePage(),
        '/classes': (context) => ClassesPage(), // Add route for ClassesPage
      },
    );
  }
}