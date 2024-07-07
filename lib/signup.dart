import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'login.dart';

class SignupPage extends StatelessWidget {
  TextEditingController username = TextEditingController();
  TextEditingController student_id = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController password2 = TextEditingController();
  String response = "";
  String serverAddress = "172.21.192.1";

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
                SizedBox(height: 50),
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
                    'به دانشگاه شهید بهشتی خوش آمدید',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'حساب کاربری خود را ایجاد کنید',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 30),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    controller: username,
                    decoration: InputDecoration(
                      labelText: 'نام کاربری',
                      hintText: 'نام کاربری خود را وارد کنید',
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Icon(Icons.person, color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    controller: student_id,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'شماره دانشجویی',
                      hintText: 'شماره دانشجویی خود را وارد کنید',
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Icon(Icons.email, color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    controller: password,
                    decoration: InputDecoration(
                      labelText: 'رمز عبور',
                      hintText: 'رمز عبور خود را وارد کنید',
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Icon(Icons.lock, color: Colors.grey),
                    ),
                    obscureText: true,
                  ),
                ),
                SizedBox(height: 10),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextField(
                    controller: password2,
                    decoration: InputDecoration(
                      labelText: 'تکرار رمز عبور',
                      hintText: 'رمز عبور خود را دوباره وارد کنید',
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Icon(Icons.lock, color: Colors.grey),
                    ),
                    obscureText: true,
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.indigo),
                  ),
                  onPressed: () {
                    registerUser(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                    child: Text(
                      'ثبت نام',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'حساب کاربری دارید؟ وارد شوید',
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

  Future<void> registerUser(BuildContext context) async {
    try {
      final socket = await Socket.connect(serverAddress, 8080);

      var postRequest = jsonEncode({
        'command': 'POST:register',
        'username': username.text,
        'studentId': student_id.text,
        'password': password.text,
        'password2': password2.text,
      });

      socket.writeln(postRequest);
      await socket.flush();

      // Buffer to collect the response
      StringBuffer responseBuffer = StringBuffer();

      socket.listen(
            (List<int> data) {
          String serverResponse = String.fromCharCodes(data);
          responseBuffer.write(serverResponse);

          if (serverResponse.endsWith('\n')) {
            handleServerResponse(responseBuffer.toString().trim(), context);
            responseBuffer.clear();
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
      print('Error: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Connection Error'),
            content: Text('Failed to connect to the server.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void handleServerResponse(String response, BuildContext context) {
    var jsonResponse = jsonDecode(response);
    String status = jsonResponse['status'];
    String message = jsonResponse['message'];

    if (status == 'success') {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Registration Successful'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Registration Failed'),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
