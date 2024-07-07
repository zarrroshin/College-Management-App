import 'package:flutter/material.dart';

// Assume LoginPage is defined elsewhere
// import 'path_to_your_login_page.dart';

class ProfilePage extends StatelessWidget {
  TextEditingController usernameController = TextEditingController();
  TextEditingController studentIdController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  // Initialize initial values
  ProfilePage() {
    usernameController.text = 'علی محمدی '; // Set initial value for نام کاربری field
    studentIdController.text = '402249087';
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
        ), // Profile Page
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Implement log-out confirmation dialog
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('خروج از حساب کاربری'),
                    content: Text('آیا از خروج از حساب کاربری خود مطمئن هستید؟'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          // Perform log-out action
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
              // Default Image of Student
              Center(
                child: Container(
                  margin: EdgeInsets.only(bottom: 16),
                  height: 190,
                  width: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/profile_picture.jpg'), // Placeholder image
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              // Username Field
              buildEditableField(
                context,
                'نام کاربری                                                                                         ',
                'نام کاربری خود را وارد کنید',
                usernameController,
                false, // Non-editable
              ),
              SizedBox(height: 10),

              // Student ID Field
              buildEditableField(
                context,
                'شماره دانشجویی                                                                                        ',
                'شماره دانشجویی خود را وارد کنید',
                studentIdController,
                false, // Non-editable
              ),
              SizedBox(height: 10),

              // Department Field
              buildEditableField(
                context,
                'دانشکده                                                                                        ',
                'دانشکده خود را وارد کنید',
                departmentController,
              ),
              SizedBox(height: 10),

              // Phone Field
              buildEditableField(
                context,
                'شماره تماس                                                                                        ',
                'شماره تماس خود را وارد کنید',
                phoneController,
              ),
              SizedBox(height: 80),

              // Save Button
              ElevatedButton(
                onPressed: () {
                  // Save profile changes logic here
                  // Example: Update backend or local storage with new information
                  // You can access the edited values from controllers:
                  // usernameController.text, studentIdController.text, etc.
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

              // Delete Account Button
              TextButton(
                onPressed: () {
                  // Implement delete account logic here
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

  Widget buildEditableField(BuildContext context, String label, String hint, TextEditingController controller, [bool editable = true]) {
    return TextFormField(
      controller: controller,
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        filled: true,
        fillColor: Colors.grey[200], // Background color
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        suffixIcon: editable
            ? IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            // Implement edit functionality
            // You can use setState or showModalBottomSheet for editing
          },
        )
            : null,
      ),
      enabled: editable,
    );
  }
}