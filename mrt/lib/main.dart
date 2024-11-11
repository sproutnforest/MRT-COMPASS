import 'package:flutter/material.dart';
import 'package:mrt/Screens/first_screen.dart';
import 'package:mrt/Screens/Home_screen.dart'; // Pastikan kelas yang benar untuk HomePage
import 'package:mrt/Screens/home_screen.dart'; // Pastikan kelas yang benar untuk HomePage
import 'package:mrt/constant.dart'; // Pastikan kPrimaryColor ada di sini
import 'package:mrt/presentation/splash_screen.dart';
import 'package:mrt/Screens/Routes.dart';

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
        '/': (context) => const SplashScreen(), // SplashScreen
        '/first': (context) => const FirstScreen(), // FirstScreen
        '/home': (context) => const HomePage(), // HomePage as route
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: const Center(
        child: Text("This is the Home Page!"),
      ),
    );
  }
}
