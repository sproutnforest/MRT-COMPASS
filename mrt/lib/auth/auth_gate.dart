// import 'dart:developer';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:mrt/Screens/Home_screen.dart';
// import 'package:mrt/Screens/Routes.dart';
// import 'package:mrt/Screens/first_screen.dart';

// class AuthGate extends StatelessWidget {
//   const AuthGate({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: StreamBuilder<User?>(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           // if (snapshot.connectionState == ConnectionState.waiting) {
//           //   return const Center(child: CircularProgressIndicator());
//           // }

//           // if (snapshot.hasData) {
//               Navigator.pushReplacementNamed(context, '/first');
//           // } else {
//           //     Navigator.pushReplacementNamed(context, '/login');
            
//           // }

//           // Return an empty container to avoid UI disruption while navigating
//           return Container();
//         },
//       ),
//     );
//   }
// }
