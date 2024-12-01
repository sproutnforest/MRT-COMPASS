import 'package:flutter/material.dart';
import 'dart:async';
import 'package:mrt/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    // Jalankan timer 7 detik dan cek UID setelahnya
    Timer(const Duration(seconds: 7), _checkUid);
  }

  Future<void> _checkUid() async {
    final prefs = await SharedPreferences.getInstance();
    final uid = prefs.getString('uid'); 
    if (uid == null || uid.isEmpty) {
      Navigator.pushReplacementNamed(context, '/first');
    } else {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 1,
              color:kPrimaryColor,
              child: Opacity(
                opacity:
                    0, 
                child: Image.asset(
                  'assets/pt1.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: const Offset(125, 350),
            child: Image.asset(
              'assets/tr1.png',
              width: 100,
              height: 100,
            ),
          ),
          // Center(
          //   child: Column(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       const SizedBox(height: 50),
          //       Transform.translate(
          //         offset: const Offset(0, -165),
          //         child: const Text(
          //           "MRT COMPASS",
          //           style: TextStyle(
          //             fontSize: 45,
          //             fontWeight: FontWeight.w800,
          //             color: kPrimaryLightColor,
          //             fontFamily: 'Montserrat',
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
