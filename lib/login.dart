import 'dart:async';
import 'dart:convert'; // Import for JSON encoding/decoding
import 'dart:io';
import 'dart:typed_data';

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
  String serverAddress = "172.21.192.1"; // Default to localhost

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
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
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
                ),
                SizedBox(height: 20),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
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
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.indigo),
                  ),
                  onPressed: () {
                    checklogin();
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                    child: Text(
                      'ورود',
                      style: TextStyle(fontSize: 18, color: Colors.white),
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
                  child: Text(
                    'حساب کاربری ندارید؟ ثبت نام کنید',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> checklogin() async {
    try {
      final socket = await Socket.connect(serverAddress, 8080);

      var postRequest = jsonEncode({
        'command': 'POST:login',
        'username': student_id.text,
        'password': password.text,
      });

      socket.writeln(postRequest);
      await socket.flush();

      print("Waiting for server response...");

      // Buffer to collect the response
      StringBuffer responseBuffer = StringBuffer();

      // Read the response from the server
      socket.listen(
            (Uint8List data) {
          String serverResponse = String.fromCharCodes(data);
          responseBuffer.write(serverResponse);
          print("Response received: $serverResponse");

          if (serverResponse.endsWith('\n')) {
            // Process the response when a complete line is received
            handleServerResponse(responseBuffer.toString().trim());
            responseBuffer.clear(); // Clear the buffer for future responses
          }
        },
        onDone: () {
          print("Connection closed by server");
          socket.close();
        },
        onError: (error) {
          print("Error: $error");
          socket.close();
        },
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      print("Error: $e");
    }
  }

  void handleServerResponse(String response) {
    var jsonResponse = jsonDecode(response);
    String status = jsonResponse['status'];
    String message = jsonResponse['message'];

    if (status == 'success') {
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage()),
      );
    } else {
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}
