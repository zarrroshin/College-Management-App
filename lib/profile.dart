import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  TextEditingController nameController = TextEditingController();
  TextEditingController studentIdController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Name Field
              buildEditableField(
                context,
                'نام و نام خانوادگی                                                   ',
                'نام و نام خانوادگی خود را وارد کنید',
                nameController,
              ),
              SizedBox(height: 10),

              // Student ID Field
              buildEditableField(
                context,
                'شماره دانشجویی                                                        ',
                'شماره دانشجویی خود را وارد کنید',
                studentIdController,
              ),
              SizedBox(height: 10),

              // Department Field
              buildEditableField(
                context,
                'دانشکده                                                              ',
                'دانشکده خود را وارد کنید',
                departmentController,
              ),
              SizedBox(height: 10),

              // Email Field
              buildEditableField(
                context,
                'ایمیل                                                              ',
                'ایمیل خود را وارد کنید',
                emailController,
              ),
              SizedBox(height: 10),

              // Phone Field
              buildEditableField(
                context,
                'شماره تماس                                                          ',
                'شماره تماس خود را وارد کنید',
                phoneController,
              ),
              SizedBox(height: 20),

              // Save Button
              ElevatedButton(
                onPressed: () {
                  // Save profile changes logic here
                  // Example: Update backend or local storage with new information
                  // You can access the edited values from controllers:
                  // nameController.text, studentIdController.text, etc.
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
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEditableField(BuildContext context, String label, String hint, TextEditingController controller) {
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
        suffixIcon: IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            // Implement edit functionality
            // You can use setState or showModalBottomSheet for editing
          },
        ),
      ),
    );
  }
}
