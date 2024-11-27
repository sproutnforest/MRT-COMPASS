import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart';  // Make sure you have a HomeScreen widget
import 'register_screen.dart';  // For the "Sign Up" screen
import "package:mrt/constant.dart";  // Replace with actual constants if needed

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool showPassword = false;

  // SignIn function
  void signIn() async {
  final email = emailController.text.trim();
  final password = passwordController.text.trim();

  if (email.isEmpty || password.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Email dan password tidak boleh kosong')),
    );
    return;
  }

  try {
    // Sign in with Firebase
    final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Navigate to the HomePage
    if (userCredential.user != null) {
      emailController.clear();
      passwordController.clear();

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
      }
    } else {
      throw 'Login gagal, coba lagi';
    }
  } catch (error) {
    // Handle login error
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Sign-in failed: ${error.toString()}')),
    );
    debugPrint('Error during sign-in: $error');
  }
}


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          buildBackground(size),
          buildLoginForm(size),
        ],
      ),
    );
  }

  // Background widget
  Widget buildBackground(Size size) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              Image.asset(
                'assets/longtrain.png', // Replace with your actual asset
                fit: BoxFit.contain,
                width: size.width,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Login form widget
  Widget buildLoginForm(Size size) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Sign In",
              style: TextStyle(
                fontSize: 50,
                fontFamily: 'Serif',
                fontWeight: FontWeight.w900,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            const SizedBox(height: 20),
            buildTextField("Email", Icons.email, emailController, false),
            const SizedBox(height: 15),
            buildTextField("Password", Icons.lock, passwordController, true),
            const SizedBox(height: 20),
            buildLoginButton(),
            const SizedBox(height: 15),
            buildRegisterText(),
          ],
        ),
      ),
    );
  }

  // Register text to navigate to the register screen
  Widget buildRegisterText() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RegisterScreen()),
        );
      },
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don't have an Account? ",
            style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 14.5,
                fontFamily: 'Serif'),
          ),
          Text(
            "Sign Up",
            style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 15,
                fontWeight: FontWeight.bold,
                fontFamily: 'Serif'),
          ),
        ],
      ),
    );
  }

  // TextField widget
  Widget buildTextField(String hintText, IconData icon,
      TextEditingController controller, bool isPassword) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      width: 300,
      decoration: BoxDecoration(
        color: kSecondaryColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Icon(icon, color: Colors.black),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: isPassword ? !showPassword : false,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: const TextStyle(color: Colors.black, fontSize: 18),
                suffixIcon: isPassword
                    ? IconButton(
                        icon: Icon(
                          showPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                      )
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Login button widget
  Widget buildLoginButton() {
    return GestureDetector(
      onTap: signIn, // Call the signIn method when the button is tapped
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        width: 300,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.login, color: Colors.white),
            SizedBox(width: 20),
            Text(
              "Sign In",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Serif',
              ),
            ),
          ],
        ),
      ),
    );
  }
}