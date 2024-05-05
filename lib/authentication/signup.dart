import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _vehicleNumberController = TextEditingController();
  final TextEditingController _vehicleTypeController = TextEditingController();
  String _selectedRole = 'admin'; // Default role selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup'),
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            TabBar(
              tabs: [
                Tab(text: 'Admin'),
                Tab(text: 'User'),
                Tab(text: 'Agent'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  buildSignupForm('admin'),
                  buildSignupForm('user'),
                  SingleChildScrollView(child: buildSignupForm('agent')), // Wrap agent form with SingleChildScrollView
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSignupForm(String role) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
          ),
          if (role == 'agent') ...[
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: _contactController,
                decoration: InputDecoration(
                  labelText: 'Contact No',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: _vehicleNumberController,
                decoration: InputDecoration(
                  labelText: 'Vehicle Number',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: _vehicleTypeController,
                decoration: InputDecoration(
                  labelText: 'Vehicle Type',
                ),
              ),
            ),
          ],
          ElevatedButton(
            onPressed: () async {
              try {
                // Check if all required fields are filled
                if (_emailController.text.trim().isEmpty ||
                    _passwordController.text.trim().isEmpty ||
                    (role == 'agent' &&
                        (_nameController.text.trim().isEmpty ||
                            _contactController.text.trim().isEmpty ||
                            _vehicleNumberController.text.trim().isEmpty ||
                            _vehicleTypeController.text.trim().isEmpty))) {
                  // Show error message if any required field is empty
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please fill all required fields')),
                  );
                  return;
                }

                UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
                  email: _emailController.text.trim(),
                  password: _passwordController.text.trim(),
                );

                // Save user data to Firestore
                await _firestore.collection('users').doc(_emailController.text.trim()).set({
                  'role': role,
                  'name': _nameController.text.trim(), // Add name for agents
                  'contact': _contactController.text.trim(), // Add contact for agents
                  'vehicle_number': _vehicleNumberController.text.trim(), // Add vehicle number for agents
                  'vehicle_type': _vehicleTypeController.text.trim(), // Add vehicle type for agents
                  // Add other user data here
                });

                // Navigate to getstarted page or home screen
                Navigator.pop(context); // Navigate back to previous screen
                print('successfully added');
              } catch (e) {
                print(e.toString());
                // Handle signup error
              }
            },
            child: Text('Signup as $role'),
          ),
        ],
      ),
    );
  }
}
