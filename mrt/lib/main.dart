import 'package:flutter/material.dart';
import 'package:mrt/Screens/Home_screen.dart';
import 'package:mrt/Screens/Routes.dart';
import 'package:mrt/Screens/login_screen.dart';
import 'package:mrt/constant.dart'; 
import 'package:mrt/Screens/first_screen.dart';
import 'package:mrt/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mrt/presentation/splash_screen.dart';
import 'package:mrt/Screens/ticket_screen_history.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); 
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
      initialRoute: '/', 
      routes: {
        '/': (context) => const SplashScreen(),  // Menunjuk ke SplashScreen
        '/first': (context) => const FirstScreen(),  // FirstScreen setelah SplashScreen
        '/home': (context) => const HomePage(),  // Halaman utama HomePage
        '/login': (context) => const LoginScreen(),  // Login jika belum login
        '/ticket': (context) => const TicketHistoryScreen(),  // History Tiket
      },
    );
  }
}
