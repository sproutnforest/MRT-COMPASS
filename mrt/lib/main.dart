import 'package:flutter/material.dart';
import 'package:mrt/Screens/first_screen.dart';
import 'package:mrt/Screens/Home_screen.dart';  // Ganti dengan HomePage atau Home_screen yang benar
import 'package:mrt/presentation/splash_screen.dart';
import 'package:mrt/constant.dart'; // Pastikan kPrimaryColor ada di sini

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: '/', // Route pertama yang akan dibuka
      routes: {
        '/': (context) => SplashScreen(), // SplashScreen
        '/first': (context) => FirstScreen(), // FirstScreen
        '/home': (context) => HomePage(), // Ganti dengan kelas yang benar, HomePage
      },
    );
  }
}
