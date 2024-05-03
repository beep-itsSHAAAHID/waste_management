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
                  buildSignupForm('agent'),
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
          ElevatedButton(
            onPressed: () async {
              try {
                UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
                  email: _emailController.text.trim(),
                  password: _passwordController.text.trim(),
                );

                // Save user data to Firestore
                await _firestore.collection('users').doc(_emailController.text.trim()).set({
                  'role': role,
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


