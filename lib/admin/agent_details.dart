import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AgentDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Sample data for demonstration
    List<Map<String, String>> agents = [
      {'name': 'Agent 1', 'phone': '1234567890', 'email': 'agent1@example.com'},
      {'name': 'Agent 2', 'phone': '0987654321', 'email': 'agent2@example.com'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Agent Details', style: GoogleFonts.poppins(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: agents.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name: ${agents[index]['name']}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Phone: ${agents[index]['phone']}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Email: ${agents[index]['email']}',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
