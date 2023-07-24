// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:quest/login/pages/add_email.dart';

// class HomePage extends StatefulWidget {
//   HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final user = FirebaseAuth.instance.currentUser!;

//   void signUserOut() {
//     FirebaseAuth.instance.signOut();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: (() {
//           AddEmail(user.email!);
//         }),
//         child: Icon(Icons.add),
//         backgroundColor: Colors.grey[800],
//       ),
//       backgroundColor: Colors.grey[200],
//       appBar: AppBar(
//         backgroundColor: Colors.grey[900],
//         actions: [IconButton(onPressed: signUserOut, icon: Icon(Icons.logout))],
//       ),
//       body: Center(
//         child: Text(
//           "Logged In as " + user.email!,
//           style: TextStyle(
//               fontSize: 16.0,
//               fontWeight: FontWeight.bold,
//               color: Colors.grey[700]),
//         ),
//       ),
//     );
//   }
// }
