import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ComplaintsPage extends StatelessWidget {
  final TextEditingController _complaintController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Complaints'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Complaint',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            TextFormField(
              controller: _complaintController,
              maxLines: 5, // Adjust as needed
              decoration: InputDecoration(
                labelText: 'Enter your complaint here',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                submitComplaint(context);
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  void submitComplaint(BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection('user_complaints').add({
        'complaint': _complaintController.text.trim(),
        'user': FirebaseAuth.instance.currentUser!.email,
        // Add more fields if needed
      });
      _complaintController.clear();
      Navigator.pop(context); // Navigate back to previous screen
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Complaint submitted successfully!'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      print('Error submitting complaint: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error submitting complaint. Please try again.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
