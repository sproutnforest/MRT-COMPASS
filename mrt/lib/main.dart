// import 'package:mrt/Screens/Routes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mrt/Screens/home_screen.dart';
import 'package:mrt/Screens/first_screen.dart';
// import 'package:mrt/Screens/home_screen.dart';
import 'package:mrt/constant.dart'; 
import 'package:mrt/presentation/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
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




