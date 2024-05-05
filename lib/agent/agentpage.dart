import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../agent/my_profile_page.dart';


class CollectionAgentPage extends StatefulWidget {
  @override
  _CollectionAgentPageState createState() => _CollectionAgentPageState();
}

class _CollectionAgentPageState extends State<CollectionAgentPage> {
  late Future<List<Map<String, dynamic>>> futureOrders;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool inProgress = false;
  bool picked = false;
  bool pending = false;
  bool isOnlinePayment = false; // Track if online payment is selected

  @override
  void initState() {
    super.initState();
    futureOrders = fetchOrders();
  }

  Future<List<Map<String, dynamic>>> fetchOrders() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('orders').get();
      return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      print("Error fetching orders: $e");
      return [];
    }
  }

  void _signOut(BuildContext context) {
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Delivery Boy'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Column(
          children: [
            Container(
              color: Colors.green,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/profile_photo.jpg'),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Delivery Boy ',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Divider(),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _signOut(context);
                    },
                    child: Text('Sign Out'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: futureOrders,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var order = snapshot.data![index];
                        String details = "Address: ${order['address']}, District: ${order['district']}, State: ${order['state']}, Pincode: ${order['pincode']}";
                        String analysisDetails = "Prediction: ${order['analysisResults']['most_likely_prediction']}, Probability: ${(order['analysisResults']['probability'] ?? 0).toStringAsFixed(2)}, Category: ${order['analysisResults']['category']}";

                        return GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return StatefulBuilder(
                                  builder: (BuildContext context, setState) {
                                    return AlertDialog(
                                      title: Text('Update Order Status'),
                                      content: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CheckboxListTile(
                                              title: Text('In Progress'),
                                              value: inProgress,
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  inProgress = value!;
                                                  if (value!) {
                                                    picked = false;
                                                    pending = false;
                                                  }
                                                });
                                              },
                                            ),
                                            CheckboxListTile(
                                              title: Text('Picked'),
                                              value: picked,
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  picked = value!;
                                                  if (value!) {
                                                    inProgress = false;
                                                    pending = false;
                                                    if (picked) {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext context) {
                                                          return AlertDialog(
                                                            title: Text('Payment'),
                                                            content: SingleChildScrollView(
                                                              child: Column(
                                                                mainAxisSize: MainAxisSize.min,
                                                                children: [
                                                                  Text('Select Payment Method:'),
                                                                  ElevatedButton(
                                                                    onPressed: () {
                                                                      setState(() {
                                                                        isOnlinePayment = true;
                                                                      });
                                                                      Navigator.pop(context);
                                                                    },
                                                                    child: Text('Online'),
                                                                  ),
                                                                  ElevatedButton(
                                                                    onPressed: () {
                                                                      setState(() {
                                                                        isOnlinePayment = false;
                                                                      });
                                                                      Navigator.pop(context);
                                                                    },
                                                                    child: Text('Offline'),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            actions: <Widget>[
                                                              ElevatedButton(
                                                                onPressed: isOnlinePayment || !picked ? null : () {
                                                                  // Update order status to 'Paid' only if online payment is selected and order is picked
                                                                  Navigator.pop(context);
                                                                },
                                                                child: Text('Paid'),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    }
                                                  }
                                                });
                                              },
                                            ),
                                            CheckboxListTile(
                                              title: Text('Pending'),
                                              value: pending,
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  pending = value!;
                                                  if (value!) {
                                                    inProgress = false;
                                                    picked = false;
                                                  }
                                                });
                                              },
                                            ),
                                            SizedBox(height: 8),
                                            ElevatedButton(
                                              onPressed: () {
                                                // Update order status based on checkbox values
                                                if (inProgress) {
                                                  // Change order status to 'In Progress'
                                                }
                                                if (picked) {
                                                  // Change order status to 'Picked'
                                                }
                                                if (pending) {
                                                  // Change order status to 'Pending'
                                                }
                                              },
                                              child: Text('Update Status'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Order ${index + 1}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 5),
                                Text(details),
                                SizedBox(height: 5),
                                Text(
                                  analysisDetails,
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Text("No orders found");
                  }
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.lightGreen, // Light green background color
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyProfilePage(userEmail: _auth.currentUser!.email!)),
                    );
                  },
                  child: Text(
                    'My Profile',
                    style: TextStyle(color: Colors.black), // Black text color
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
