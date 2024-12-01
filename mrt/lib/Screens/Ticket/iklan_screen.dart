import 'package:flutter/material.dart';

class IklanScreen extends StatefulWidget {
  const IklanScreen({Key? key}) : super(key: key);

  @override
  State<IklanScreen> createState() => _IklanScreenState();
}

class _IklanScreenState extends State<IklanScreen> {
  

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
                fontFamily: 'serif',
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Expanded(
          child: ListView.builder(
            itemCount: 11,
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
                child: Image.asset(
                      'assets/iklan${index + 1}.png',
                      fit: BoxFit.fill,
                      
                    
                  ),
              );
            },
          ),
        ),
       
      ),
    );
  }
}
