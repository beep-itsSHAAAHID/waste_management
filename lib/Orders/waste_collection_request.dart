import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CollectionRequests extends StatefulWidget {
  const CollectionRequests({Key? key}) : super(key: key);

  @override
  State<CollectionRequests> createState() => _CollectionRequestsState();
}

class _CollectionRequestsState extends State<CollectionRequests> {
  late Future<List<Map<String, String>>> requestsFuture;

  @override
  void initState() {
    super.initState();
    requestsFuture = _fetchRequests();
  }

  Future<List<Map<String, String>>> _fetchRequests() async {
    // Fetch data from Firestore collection
    QuerySnapshot querySnapshot =
    await FirebaseFirestore.instance.collection('orders').get();

    // Extract data from QuerySnapshot and convert it to List<Map<String, String>>
    List<Map<String, String>> requests = querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return {
        'name': (data['name'] ?? '').toString(),
        'address': (data['address'] ?? '').toString(),
        'pincode': (data['pincode'] ?? '').toString(),
        'district': (data['district'] ?? '').toString(),
        'state': (data['state'] ?? '').toString(),
      };
    }).toList();

    return requests;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Collection Requests'),
      ),
      body: FutureBuilder<List<Map<String, String>>>(
        future: requestsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<Map<String, String>> requests = snapshot.data ?? [];
            return ListView.builder(
              itemCount: requests.length,
              itemBuilder: (context, index) {
                final request = requests[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ListTile(
                      title: Text(
                        request['name']!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text('${request['address']},${request['district']}, ${request['state']}, ${request['pincode']}'),
                      trailing: Icon(Icons.arrow_forward),
                      onTap: () {
                        _showPopup(context, request);
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  void _showPopup(BuildContext context, Map<String, String> request) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Details'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Address: ${request['address']}'),
              Text('District: ${request['district']}'),
              Text('State: ${request['state']}'),
              Text('Pincode: ${request['pincode']}'),
              Text('Type of waste: Organic'),
              Text('Quantity: 20'),
            ],
          ),
          actions: [
            TextButton.icon(
              onPressed: () {
                // Handle accept action
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.check),
              label: Text('Accept'),
            ),
            TextButton.icon(
              onPressed: () {
                // Handle reject action
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.close),
              label: Text('Reject'),
            ),
          ],
        );
      },
    );
  }
}
