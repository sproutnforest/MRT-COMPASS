import 'package:flutter/material.dart';
import 'package:mrt/Screens/Home_screen.dart';
import 'package:mrt/Screens/Routes.dart';
import 'package:mrt/Screens/login_screen.dart';
import 'package:mrt/constant.dart'; // Pastikan kPrimaryColor ada di sini
import 'package:mrt/Screens/first_screen.dart';
import 'package:mrt/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mrt/presentation/splash_screen.dart';
import 'package:mrt/Screens/ticket_screen_history.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp();
  }
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
        '/home': (context) => const HomePage(), // HomePage route
        '/login': (context) => const LoginScreen(), // LoginPage route (for when the user is not logged in)
        '/ticket': (context) => const TicketHistoryScreen() //History Tiket
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        // home: AuthGate()
        );
  }
}
