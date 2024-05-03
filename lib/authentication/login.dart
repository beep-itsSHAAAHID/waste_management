import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:waste_management/admin/admin_home.dart';
import 'package:waste_management/agent/agentpage.dart';
import 'package:waste_management/user/userpage.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
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
              onPressed: () => _login(),
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

Future<void> _login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      // Redirect based on role
      String? role = await getUserRole(_emailController.text.trim());
      if (role == 'admin') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AdminHomePage()),
        );
      } else if (role == 'user') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => UserPage()),
        );
      } else if (role == 'agent') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CollectionAgentPage()),
        );
      }
    } catch (e) {
      print(e.toString());
      // Handle login error
    }
  }

  Future<String?> getUserRole(String email) async {
    try {
      // Reference to the 'users' collection
      DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(email) // Assuming email is the document ID
          .get();

      if (docSnapshot.exists) {
        // Assuming 'role' is a field in your document
        return docSnapshot.get('role');
      } else {
        print('User not found');
        return null;
      }
    } catch (e) {
      print('Error fetching user role: $e');
      return null;
    }
  }
}
