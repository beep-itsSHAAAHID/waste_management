// import 'package:flutter/material.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Get Started',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       initialRoute: '/get_started',
//       routes: {
//         '/get_started': (context) => GetStartedPage(),
//         '/user_login': (context) => UserLoginPage(),
//         '/agent_login': (context) => AgentLoginPage(),
//         '/user_dashboard': (context) => UserDashboardPage(),
//         '/dashboard': (context) => AgentDashboardPage(),
//         '/user_register': (context) => UserRegisterPage(),
//         '/agent_register': (context) => AgentRegisterPage(),
//         '/forgot_password': (context) => ForgotPasswordPage(),
//       },
//     );
//   }
// }
//
// class GetStartedPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Get Started'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, '/user_login');
//               },
//               child: Text('User'),
//             ),
//             SizedBox(height: 16.0),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, '/agent_login');
//               },
//               child: Text('Collecting Agent'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
//
// class AgentLoginPage extends StatefulWidget {
//   @override
//   _AgentLoginPageState createState() => _AgentLoginPageState();
// }
//
// class _AgentLoginPageState extends State<AgentLoginPage> {
//   final _formKey = GlobalKey<FormState>();
//   late String _name;
//   late String _password;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Collecting Agent Login'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: <Widget>[
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Name'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your name';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _name = value!;
//                 },
//               ),
//               SizedBox(height: 16.0),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Password'),
//                 obscureText: true,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your password';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _password = value!;
//                 },
//               ),
//               SizedBox(height: 16.0),
//               TextButton(
//                 onPressed: () {
//                   Navigator.pushNamed(context, '/forgot_password');
//                 },
//                 child: Text('Forgot Password?'),
//               ),
//               SizedBox(height: 32.0),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     _formKey.currentState!.save();
//                     // Perform agent login logic
//                     Navigator.pushReplacementNamed(context, '/dashboard');
//                   }
//                 },
//                 child: Text('Login'),
//               ),
//               SizedBox(height: 16.0),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Text("Don't have an account?"),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.pushNamed(context, '/agent_register');
//                     },
//                     child: Text('Sign Up'),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class UserRegisterPage extends StatefulWidget {
//   @override
//   _UserRegisterPageState createState() => _UserRegisterPageState();
// }
//
// class _UserRegisterPageState extends State<UserRegisterPage> {
//   final _formKey = GlobalKey<FormState>();
//   late String _name;
//   late String _email;
//   late String _password;
//   late String _confirmPassword;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User Sign Up'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: <Widget>[
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Name'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your name';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _name = value!;
//                 },
//               ),
//               SizedBox(height: 16.0),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Email'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your email';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _email = value!;
//                 },
//               ),
//               SizedBox(height: 16.0),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Password'),
//                 obscureText: true,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your password';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _password = value!;
//                 },
//               ),
//               SizedBox(height: 16.0),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Confirm Password'),
//                 obscureText: true,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please confirm your password';
//                   }
//                   if (value != _password) {
//                     return 'Passwords do not match';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _confirmPassword = value!;
//                 },
//               ),
//               SizedBox(height: 32.0),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     _formKey.currentState!.save();
//                     // Perform user registration logic
//                     Navigator.pushReplacementNamed(context, '/user_login');
//                   }
//                 },
//                 child: Text('Sign Up'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class AgentRegisterPage extends StatefulWidget {
//   @override
//   _AgentRegisterPageState createState() => _AgentRegisterPageState();
// }
//
// class _AgentRegisterPageState extends State<AgentRegisterPage> {
//   final _formKey = GlobalKey<FormState>();
//   late String _name;
//   late String _email;
//   late String _password;
//   late String _confirmPassword;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Collecting Agent Sign Up'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: <Widget>[
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Name'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your name';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _name = value!;
//                 },
//               ),
//               SizedBox(height: 16.0),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Email'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your email';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _email = value!;
//                 },
//               ),
//               SizedBox(height: 16.0),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Password'),
//                 obscureText: true,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your password';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _password = value!;
//                 },
//               ),
//               SizedBox(height: 16.0),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Confirm Password'),
//                 obscureText: true,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please confirm your password';
//                   }
//                   if (value != _password) {
//                     return 'Passwords do not match';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _confirmPassword = value!;
//                 },
//               ),
//               SizedBox(height: 32.0),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     _formKey.currentState!.save();
//                     // Perform agent registration logic
//                     Navigator.pushReplacementNamed(context, '/agent_login');
//                   }
//                 },
//                 child: Text('Sign Up'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class UserDashboardPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User Dashboard'),
//       ),
//       body: Center(
//         child: Text('Welcome User!'),
//       ),
//     );
//   }
// }
//
// class AgentDashboardPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Dashboard'),
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             DrawerHeader(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   CircleAvatar(
//                     radius: 30,
//                     backgroundColor: Colors.grey,
//                     child: Icon(
//                       Icons.person,
//                       size: 40,
//                       color: Colors.white,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   Text(
//                     'Welcome Agent!!!',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//               decoration: BoxDecoration(
//                 color: Colors.blue,
//               ),
//             ),
//             ListTile(
//               title: Text('Profile'),
//               onTap: () {
//                 // Navigate to profile page
//               },
//             ),
//             ListTile(
//               title: Text('Home'),
//               onTap: () {
//                 // Navigate to home page
//               },
//             ),
//             ListTile(
//               title: Text('Order History'),
//               onTap: () {
//                 // Navigate to order history page
//               },
//             ),
//             ListTile(
//               title: Text('Help'),
//               onTap: () {
//                 // Navigate to help page
//               },
//             ),
//             ListTile(
//               title: Text('Logout'),
//               onTap: () {
//                 // Perform logout logic
//               },
//             ),
//           ],
//         ),
//       ),
//       body: Row(
//         children: [
//           Expanded(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         // Navigate to total orders page
//                       },
//                       child: Container(
//                         width: 150,
//                         height: 100,
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.black),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Center(
//                           child: Text(
//                             'Total Orders',
//                             style: TextStyle(fontSize: 16),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 16),
//                     GestureDetector(
//                       onTap: () {
//                         // Navigate to pending orders page
//                       },
//                       child: Container(
//                         width: 150,
//                         height: 100,
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.black),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Center(
//                           child: Text(
//                             'Pending Orders',
//                             style: TextStyle(fontSize: 16),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 16),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         // Navigate to completed orders page
//                       },
//                       child: Container(
//                         width: 150,
//                         height: 100,
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.black),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Center(
//                           child: Text(
//                             'Completed Orders',
//                             style: TextStyle(fontSize: 16),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 16),
//                     GestureDetector(
//                       onTap: () {
//                         // Navigate to status order details page
//                       },
//                       child: Container(
//                         width: 150,
//                         height: 100,
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colors.black),
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Center(
//                           child: Text(
//                             'Status Order Details',
//                             style: TextStyle(fontSize: 16),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 16),
//                 GestureDetector(
//                   onTap: () {
//                     // Navigate to feedback page
//                   },
//                   child: Container(
//                     width: 150,
//                     height: 100,
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.black),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Center(
//                       child: Text(
//                         'Feedback',
//                         style: TextStyle(fontSize: 16),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class ForgotPasswordPage extends StatefulWidget {
//   @override
//   _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
// }
//
// class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
//   final _formKey = GlobalKey<FormState>();
//   late String _newPassword;
//   late String _confirmNewPassword;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Reset Password'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: <Widget>[
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'New Password'),
//                 obscureText: true,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your new password';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _newPassword = value!;
//                 },
//               ),
//               SizedBox(height: 16.0),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Confirm New Password'),
//                 obscureText: true,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please confirm your new password';
//                   }
//                   if (value != _newPassword) {
//                     return 'Passwords do not match';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _confirmNewPassword = value!;
//                 },
//               ),
//               SizedBox(height: 32.0),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     _formKey.currentState!.save();
//                     // Perform password reset logic
//                     Navigator.pop(context); // Navigate back to login page
//                   }
//                 },
//                 child: Text('Save'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }