import 'package:flutter/material.dart';
import 'package:mrt/constant.dart'; // Keep this import
import 'package:mrt/Screens/first_screen.dart';
import 'presentation/splash_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
      routes: {
        '/': (context) => SplashScreen(),
        '/first': (context) => FirstScreen(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: const Center(
        child: Text("This is the Home Page!"),
      ),
    );
  }
}
