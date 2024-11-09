import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.green,
      ),
      body: const Center(
        child: Text(
          'User Profile Information',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
