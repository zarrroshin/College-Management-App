import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'signup.dart';
import 'profile.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController student_id = TextEditingController();
  TextEditingController password = TextEditingController();
  String response = '';
  bool userIdchecker = true, passwordChecker = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 80),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Image.asset(
                    'assets/university_logo.jpg',
                    height: 200,
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    'خوش آمدید',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'وارد حساب کاربری خود شوید',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 40),
                TextFormField(
                  controller: student_id,
                  decoration: InputDecoration(
                    labelText: ' شماره دانشجویی / نام کاربری',
                    hintText: 'شماره دانشجویی یا نام کاربری خود را وارد کنید',
                    filled: true,
                    fillColor: Colors.grey[200], // Background color
                    border: OutlineInputBorder(
                      // Border
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(Icons.email, color: Colors.grey), // Icon
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  obscureText: true,
                  controller: password,
                  decoration: InputDecoration(
                    labelText: 'رمز عبور',
                    hintText: 'رمز عبور خود را وارد نمایید',
                    filled: true,
                    fillColor: Colors.grey[200], // Background color
                    border: OutlineInputBorder(
                      // Border
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(Icons.lock, color: Colors.grey), // Icon
                  ),
                ),
                SizedBox(height: 30),
                InkWell(
                  onTap: () async {
                    await checklogin();
                    if (response == "200") {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage()),
                      );
                    } else if (response == "401") {
                      Fluttertoast.showToast(
                        msg: "رمز عبور اشتباه است",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    } else if (response == "404") {
                      Fluttertoast.showToast(
                        msg: "نام کاربری در سامانه یافت نشد",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: Text(
                        'ورود',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupPage()),
                    );
                  },
                  child: Text('حساب کاربری ندارید؟ ثبت نام کنید',
                      style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> checklogin() async {
    Completer<String> completer = Completer();
    await Socket.connect("10.0.0.4", 8080).then((serverSocket) {
      serverSocket.write(
          'GET: loginChecker~${student_id.text}~${password.text}\u0000');
      serverSocket.flush();
      serverSocket.listen((socketresponse) {
        response = String.fromCharCodes(socketresponse);
        completer.complete(response);
      });
    });
    await completer.future;
    setState(() {
      if (response == "401") {
        userIdchecker = true;
        passwordChecker = false;
      } else if (response == "404") {
        userIdchecker = false;
        passwordChecker = false;
      } else if (response == "200") {
        userIdchecker = true;
        passwordChecker = true;
      }
    });
  }
}
