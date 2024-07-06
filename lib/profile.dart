import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        elevation: 8,
        title: Text(
          'Profile',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.indigo, Colors.blue],
            ),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Profile Picture
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/profile_picture.jpg'),
              ),
            ),
            SizedBox(height: 20),
            // Name
            buildCard('Name:', 'Farhad Ahmadi'),
            // Student ID
            buildCard('Student ID:', '402243098'),
            // Email
            buildCard('Email:', 'farhadahmadi973@gmail.com'),
            // Phone Number
            buildCard('Phone Number:', '0902341223'),
            // Date of Birth
            buildCard('Date of Birth:', '09/08/1383'),
            // Course/Program
            buildCard('Field Of Study:', 'Computer Science'),
            // Year of Study
            SizedBox(height: 20),
            // Delete Profile Button
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.indigo),
              ),
              onPressed: () {
                // Add functionality to delete profile here
              },
              child: Text(
                'Delete Profile',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard(String title, String content) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            SizedBox(height: 5),
            Text(
              content,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Roboto',
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
