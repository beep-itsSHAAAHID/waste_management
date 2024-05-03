import 'package:flutter/material.dart';
import 'package:waste_management/user/place_order_page.dart';
import 'package:waste_management/user/track_order_page.dart';

import 'complaints_page.dart';

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EcoCycle'),
        // Add leading menu icon button
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            // Open menu options
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.green, // Change color to green
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                // Navigate to home page or perform other actions
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                // Navigate to profile page or perform other actions
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
              onTap: () {
                // Navigate to about page or perform other actions
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                // Perform logout action
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Welcome Username', // Replace 'Username' with the actual username
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Quote on Waste Management',
              style: TextStyle(
                fontSize: 18.0,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                 _buildMenuButton(
                   context,
                   'Place Order',
                   Icons.add_shopping_cart,
                   PlaceOrderPage(),
                   Colors.green, // Change color to green
                 ),
                _buildMenuButton(
                  context,
                  'Track Order',
                  Icons.track_changes,
                  TrackOrderPage(),
                  Colors.green, // Change color to green
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildMenuButton(
                  context,
                  'Schedules',
                  Icons.event,
                  SchedulesPage(),
                  Colors.green, // Change color to green
                ),
                _buildMenuButton(
                  context,
                  'Complaints',
                  Icons.report_problem,
                  ComplaintsPage(),
                  Colors.green, // Change color to green
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, String text, IconData icon, Widget page, Color color) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          color: color, // Change color to green
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: Colors.white,
            ),
            SizedBox(height: 8),
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SchedulesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedules'),
      ),
      body: Center(
        child: Text('Schedules Page'),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: UserPage(),
  ));
}
