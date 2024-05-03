import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../agent/my_profile_page.dart';
import '../agent/order_history_page.dart';


class CollectionAgentPage extends StatefulWidget {
  @override
  _CollectionAgentPageState createState() => _CollectionAgentPageState();
}

class _CollectionAgentPageState extends State<CollectionAgentPage> {
  late Future<List<Map<String, dynamic>>> futureOrders;

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
    // Implement your sign-out logic here
    Navigator.popUntil(context, ModalRoute.withName('/'));  // Adjust according to your app's navigation structure
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
                    'Delivery Boy Name',  // You can make this dynamic
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

                        return ListTile(
                          title: Text(
                            'Order ${index + 1}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text("$details | $analysisDetails"),
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
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OrderHistoryPage()),
                  );
                },
                child: Text('Order History'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyProfilePage()),
                  );
                },
                child: Text('My Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
