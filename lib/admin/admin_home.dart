import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waste_management/Orders/waste_collection_request.dart';
import 'package:waste_management/admin/total_orders.dart';
import 'package:waste_management/admin/pending_orders.dart';
import 'package:waste_management/admin/completed_orders.dart';
import 'package:waste_management/admin/rejected_orders.dart';
import 'package:waste_management/admin/user_complaint.dart';
// Import the agent details page
import 'package:waste_management/admin/agent_details.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard', style: GoogleFonts.poppins(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Menu',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  Text(
                    'EcoCycle',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                  ),
                  Text(
                    'Waste Solutions',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blue, Colors.green],
                ),
              ),
            ),
            ExpansionTile(
              title: Text('Orders', style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.bold)),
              children: [
                ListTile(
                  title: Text('Waste Collection Requests', style: GoogleFonts.poppins()),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CollectionRequests()),
                    );
                  },
                ),
              ],
            ),
            // New ExpansionTile for Collecting Agent
            ExpansionTile(
              title: Text('Collecting Agent', style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.bold)),
              children: [
                ListTile(
                  title: Text('Agent Details', style: GoogleFonts.poppins()),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AgentDetailsPage()),
                    );
                  },
                ),
              ],
            ),
            Divider(),
            ListTile(
              title: Text('Log Out', style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.bold)),
              onTap: () {
                // Implement log out functionality
                Navigator.pop(context); // Close the drawer
                // Navigate to the log out screen or perform log out actions
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.green],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Welcome!',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  children: [
                    _buildGradeinstCard('Total Orders', Icons.grade,
                        [Color(0xFF8DECB4), Color(0xFF41B06E)], TotalOrdersPage()),
                    _buildGradeinstCard('Pending Orders', Icons.grade,
                        [Color(0xFF8DECB4), Color(0xFF41B06E)], PendingOrdersPage()),
                    _buildGradeinstCard(
                        'Completed Orders', Icons.grade, [Color(0xFF8DECB4), Color(0xFF41B06E)], CompletedOrdersPage()),
                    _buildGradeinstCard('Rejected Orders', Icons.grade,
                        [Color(0xFF8DECB4), Color(0xFF41B06E)], RejectedOrdersPage()),
                    _buildGradeinstCard(
                        'User Complaints', Icons.grade, [Color(0xFF8DECB4), Color(0xFF41B06E)], UserComplaintsPage()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGradeinstCard(
      String title, IconData icon, List<Color> colors, Widget destinationPage) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationPage),
        );
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: colors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
