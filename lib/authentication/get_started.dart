import 'package:flutter/material.dart';

import 'package:waste_management/authentication/login.dart';
import 'package:waste_management/authentication/signup.dart';

class GetStartedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.green],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.eco,
                  size: 100.0,
                  color: Colors.white,
                ),
                SizedBox(height: 20.0),
                Text(
                  'Welcome to EcoCycle',
                  style: TextStyle(fontSize: 24.0, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30.0),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  icon: Icon(Icons.login),
                  label: Text('Login'),
                ),
                SizedBox(height: 10.0),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Signup()),
                    );
                  },
                  icon: Icon(Icons.login),
                  label: Text('Sign Up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
