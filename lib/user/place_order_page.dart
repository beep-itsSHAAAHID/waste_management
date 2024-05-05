import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;


class PlaceOrderPage extends StatefulWidget {
  @override
  _PlaceOrderPageState createState() => _PlaceOrderPageState();
}

class _PlaceOrderPageState extends State<PlaceOrderPage> {
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;

  // Additional member for storing the picked file
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

// Method to handle image capture from the camera
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Map<String, dynamic> _resultData = {};


  Future<void> _uploadImage() async {
    if (_imageFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No image selected')),
      );
      return;
    }

    try {
      var uri = Uri.parse('http://192.168.1.8:5000/predict');
      var request = http.MultipartRequest('POST', uri)
        ..files.add(await http.MultipartFile.fromPath('file', _imageFile!.path));
      var streamedResponse = await request.send();

      if (streamedResponse.statusCode == 200) {
        var response = await http.Response.fromStream(streamedResponse);
        _resultData = jsonDecode(response.body); // Update _resultData with the parsed JSON
        var formattedResult = "Prediction: ${_resultData['most_likely_prediction']}\n"
            "Probability: ${_resultData['probability'].toStringAsFixed(2)}\n"
            "Category: ${_resultData['category']}";

        setState(() {
          _result = formattedResult; // Set the formatted result for display
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Upload successful: $formattedResult')),
        );
      } else {
        throw Exception('Failed to upload image');
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to upload image: $e')),
      );
    }
  }







  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _selectedTime = TimeOfDay.now();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  Future<void> _placeOrder() async {
    try {
      await FirebaseFirestore.instance.collection('orders').add({
        'name': _nameController.text,
        'address': _addressController.text,
        'district': _districtController.text,
        'state': _stateController.text,
        'pincode': _pincodeController.text,
        'scheduledDate': _selectedDate,
        'scheduledTime': {
          'hour': _selectedTime.hour,
          'minute': _selectedTime.minute,
        },
        // Adding image analysis results
        'analysisResults': {
          'most_likely_prediction': _resultData['most_likely_prediction'] ?? 'Not Available',
          'probability': _resultData['probability'] ?? 0,
          'category': _resultData['category'] ?? 'Not Available',
          'timestamp': FieldValue.serverTimestamp(),
        }
      });

      print("Successfully Added Order with Results");
      // Navigate to a success page or perform other actions
    } catch (e) {
      print('Error placing order: $e');
    }
  }


  String _result = '';

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Place Order'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await _pickImage();
                  await _uploadImage(); // Call upload after image is picked
                },
                child: Text('Upload Image'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              ),
              SizedBox(height: 16.0),
              if (_result.isNotEmpty) ...[
                Text(
                  'Result:',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  _result,
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                ),
              ],
              SizedBox(height: 16.0),


              Text(
                'Name',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Change color to black
                ),
              ),
              SizedBox(height: 8.0),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Enter Name',
                  labelStyle: TextStyle(color: Colors.black), // Change color to black
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Address',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Change color to black
                ),
              ),
              SizedBox(height: 8.0),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: 'Address',
                  labelStyle: TextStyle(color: Colors.black), // Change color to black
                ),
              ),
              SizedBox(height: 8.0),
              TextFormField(
                controller: _districtController,
                decoration: InputDecoration(
                  labelText: 'District',
                  labelStyle: TextStyle(color: Colors.black), // Change color to black
                ),
              ),
              SizedBox(height: 8.0),
              TextFormField(
                controller: _stateController,
                decoration: InputDecoration(
                  labelText: 'State',
                  labelStyle: TextStyle(color: Colors.black), // Change color to black
                ),
              ),
              SizedBox(height: 8.0),
              TextFormField(
                controller: _pincodeController,
                decoration: InputDecoration(
                  labelText: 'Pincode',
                  labelStyle: TextStyle(color: Colors.black), // Change color to black
                ),
              ),
              SizedBox(height: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _selectDate(context),
                    icon: Icon(Icons.calendar_today),
                    label: Text(
                      'Select Date: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                      style: TextStyle(color: Colors.black), // Change color to black
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green, // Change color to green
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Date',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Change color to black
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _selectTime(context),
                    icon: Icon(Icons.access_time),
                    label: Text(
                      'Select Time: ${_selectedTime.hour}:${_selectedTime.minute}',
                      style: TextStyle(color: Colors.black), // Change color to black
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green, // Change color to green
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Time',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Change color to black
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _placeOrder,
                child: Text('Place Order'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Change color to green
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SchedulePage extends StatelessWidget {
  final DateTime scheduledDate;
  final TimeOfDay scheduledTime;

  const SchedulePage({
    Key? key,
    required this.scheduledDate,
    required this.scheduledTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Scheduled Date: ${scheduledDate.day}/${scheduledDate.month}/${scheduledDate.year}',
              style: TextStyle(fontSize: 18.0, color: Colors.black), // Change color to black
            ),
            SizedBox(height: 16.0),
            Text(
              'Scheduled Time: ${scheduledTime.hour}:${scheduledTime.minute}',
              style: TextStyle(fontSize: 18.0, color: Colors.black), // Change color to black
            ),
          ],
        ),
      ),
    );
  }
}