import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController usernameController = TextEditingController();

  TextEditingController studentIdController = TextEditingController();

  TextEditingController departmentController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  // Replace with your actual laptop's IP address and port number
  String serverAddress = "192.168.1.119:8080";

  Future<void> fetchProducts() async {
    print("-----first");
    final response = await http.get(Uri.parse('http://$serverAddress/profileData'));
    print(response);
    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      print(jsonData);
      print("----------------------------");
    } else {
      print('Error fetching data');
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
                    content:
                        Text('آیا از خروج از حساب کاربری خود مطمئن هستید؟'),
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
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
                        content:
                            Text('آیا از حذف حساب کاربری خود مطمئن هستید؟'),
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
