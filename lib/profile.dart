import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'userdataSession.dart'; // Ensure you import your userdataSession file

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController studentIdController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  String serverAddress = "192.168.1.119:8080";

  Future<void> fetchProducts() async {
    final userdataSession = Provider.of<UserdataSession>(context, listen: false);

    try {
      final response = await http.get(Uri.parse(
          'http://${serverAddress}/profileData?studentId=${userdataSession.studentId}'));

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        print('JSON Data: $jsonData');
        final username = jsonData['username'];
        final studentId = jsonData['studentId'];
        final department = jsonData['department'];
        final phone = jsonData['phone'];

        setState(() {
          print('Updating UI with fetched data...');
          print('Username: $username');
          print('Student ID: $studentId');
          print('Department: $department');
          print('Phone: $phone');

          usernameController.text = username;
          studentIdController.text = studentId;
          departmentController.text = department;
          phoneController.text = phone;
        });

        print('UI updated with fetched data');
      } else {
        print('Error fetching data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      if (e is SocketException) {
        print('Handling connection reset by peer...');
        // Optionally, retry the request
        await Future.delayed(Duration(seconds: 2)); // Delay before retrying
        await fetchProducts(); // Retry the fetch
      }
    }
  }


  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.bottomRight,
          child: Text(
            'صفحه کاربری',
            style: TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto',
            ),
          ),
        ),
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('خروج از حساب کاربری'),
                    content: Text('آیا از خروج از حساب کاربری خود مطمئن هستید؟'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: Text('خروج'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('انصراف'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(bottom: 16),
                  height: 190,
                  width: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/profile_picture.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              buildEditableField(
                context,
                'نام کاربری',
                'نام کاربری خود را وارد کنید',
                usernameController,
                false,
              ),
              SizedBox(height: 10),
              buildEditableField(
                context,
                'شماره دانشجویی',
                'شماره دانشجویی خود را وارد کنید',
                studentIdController,
                false,
              ),
              SizedBox(height: 10),
              buildEditableField(
                context,
                'دانشکده',
                'دانشکده خود را وارد کنید',
                departmentController,
              ),
              SizedBox(height: 10),
              buildEditableField(
                context,
                'شماره تماس',
                'شماره تماس خود را وارد کنید',
                phoneController,
              ),
              SizedBox(height: 80),
              ElevatedButton(
                onPressed: () {
                  // Save profile changes logic here
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.indigo),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                  child: Text(
                    'ذخیره تغییرات',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('حذف حساب کاربری'),
                        content: Text('آیا از حذف حساب کاربری خود مطمئن هستید؟'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              // Perform delete account action
                              Navigator.pop(context);
                            },
                            child: Text('حذف'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('انصراف'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text(
                  'حذف حساب کاربری',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEditableField(BuildContext context, String label, String hint,
      TextEditingController controller,
      [bool editable = true]) {
    return TextFormField(
      controller: controller,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        suffixIcon: editable
            ? IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            // Implement edit functionality
          },
        )
            : null,
      ),
      enabled: editable,
    );
  }
}
