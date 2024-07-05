import 'login.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  TextEditingController username = TextEditingController();
  TextEditingController student_id = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController password2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.indigo,),
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
                TextFormField(
                  controller: username,
                  decoration: InputDecoration(
                    labelText: 'نام کاربری',
                    hintText:'نام کاربری خود را وارد کنید' ,
                    filled: true,
                    fillColor: Colors.grey[200], // Background color
                    border: OutlineInputBorder( // Border
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(Icons.person, color: Colors.grey), // Icon
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: student_id,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'شماره دانشجویی',
                    hintText: 'شماره دانشجویی خود را وارد کنید',
                    filled: true,
                    fillColor: Colors.grey[200], // Background color
                    border: OutlineInputBorder( // Border
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(Icons.email, color: Colors.grey), // Icon
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: password,
                  decoration: InputDecoration(
                    labelText: 'رمز عبور',
                    hintText: 'رمز عبور خود را وارد کنید',
                    filled: true,
                    fillColor: Colors.grey[200], // Background color
                    border: OutlineInputBorder( // Border
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(Icons.lock, color: Colors.grey), // Icon
                  ),
                  obscureText: true,
                ),SizedBox(height: 10),
                TextField(
                  controller: password2,
                  decoration: InputDecoration(
                    labelText: 'تکرار رمز عبور',
                    hintText: 'رمز عبور خود را دوباره وارد کنید',
                    filled: true,
                    fillColor: Colors.grey[200], // Background color
                    border: OutlineInputBorder( // Border
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(Icons.lock, color: Colors.grey), // Icon
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 30),
                ElevatedButton(style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.indigo)),

                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                    child: Text(
                      'ثبت نام',
                      style: TextStyle(fontSize: 18,color: Colors.white),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('حساب کاربری دارید؟ وارد شوید', style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
