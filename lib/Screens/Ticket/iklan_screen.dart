import 'package:flutter/material.dart';
import 'package:mrt/Screens/Ticket/buyTicket_Screen.dart';
import 'package:mrt/Screens/home_screen.dart';
import 'package:mrt/Screens/profile_screen.dart';
import 'package:mrt/Screens/widget/custom_bottom_nav.dart';

class IklanScreen extends StatefulWidget {
  const IklanScreen({super.key});

  @override
  State<IklanScreen> createState() => _IklanScreenState();
}

class _IklanScreenState extends State<IklanScreen> {
  final int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: const Color(0xFF173156),
        title: const Text('Iklan',
            style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Expanded(
          child: ListView.builder(
            itemCount: 10,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
            
              double itemHeight = 120.0;
              return Container(
                margin: const EdgeInsets.symmetric(
                    vertical: 8),
                height: itemHeight, 
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.blue.shade100,
                ),
                child: Center(
                  child: Text(
                    'Iklan ${index + 1}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              );
            },
          ),
        ),
       
      ),
    );
  }
}
