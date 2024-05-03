
import 'package:flutter/material.dart';

class SchedulesPage extends StatelessWidget {
  final DateTime scheduledDate;
  final TimeOfDay scheduledTime;

  const SchedulesPage({
    required this.scheduledDate,
     required this.scheduledTime,
  });

  @override
  Widget build(BuildContext context) {
    // Build your UI here using scheduledDate and scheduledTime
    return Scaffold(
      appBar: AppBar(
        title: Text('Scheduled Order Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Scheduled Date: ${scheduledDate.day}/${scheduledDate.month}/${scheduledDate.year}',
            style: TextStyle(fontSize: 18),
          ),
          Text(
            'Scheduled Time: ${scheduledTime.hour}:${scheduledTime.minute}',
            style: TextStyle(fontSize: 18),
          ),
          // Add more widgets to display other details as needed
        ],
      ),
    );
  }
}
