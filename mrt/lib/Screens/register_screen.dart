import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'login_screen.dart'; // Ensure this import points to the correct HomeScreen file

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _showPassword = false;

  @override
  void dispose() {
    nameController.dispose();
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
          buildRegisterForm(size),
        ],
      ),
    );
  }

  // Background Widget
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
              Transform.translate(
                offset: const Offset(-150, 430),
                child: Image.asset(
                  'assets/rmh2.png',
                  fit: BoxFit.contain,
                  width: size.width * 0.6,
                ),
              ),
              const SizedBox(height: 10),
              Image.asset(
                'assets/longtrain.png',
                fit: BoxFit.contain,
                width: size.width,
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 500,
          right: -180,
          child: Transform.rotate(
            angle: 45 * 3.141592653589793238 / 180,
            child: Image.asset(
              'assets/tangga.png',
              width: 650,
              height: 620,
            ),
          ),
        ),
      ],
    );
  }

  // Register Form Widget
  Widget buildRegisterForm(Size size) {
    return Stack(
      children: [
        Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                Transform.translate(
                  offset: const Offset(0, 0),
                  child: const Text(
                    "Register",
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.w900),
                  ),
                ),
                const SizedBox(height: 20),
                buildTextField("Name", Icons.person, nameController, false),
                const SizedBox(height: 20),
                buildTextField("Email", Icons.email, emailController, false),
                const SizedBox(height: 15),
                buildTextField(
                    "Password", Icons.lock, passwordController, true),
                const SizedBox(height: 20),
                buildRegisterButton(size),
                const SizedBox(height: 20),
                buildLoginText(),
              ],
            ),
          ),
        ),
        // Positioned Next Button
        Positioned(
          top: 30, // Position the button 30px from the top of the screen
          right: 20, // Position the button 20px from the right side
          child: buildNextButton(size),
        ),
      ],
    );
  }

  // "Next" Button widget for immediate navigation
  Widget buildNextButton(Size size) {
    return GestureDetector(
      onTap: () {
        // Directly navigate to HomeScreen when the "Next" button is clicked
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const HomePage()), // Direct navigation
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        width: 300,
        decoration: BoxDecoration(
          color: const Color(0xFF173156),
          borderRadius: BorderRadius.circular(50),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.arrow_forward, color: Colors.white),
            SizedBox(width: 20),
            Text(
              "Skip",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  // Text field widget for name/email/password
  Widget buildTextField(String hintText, IconData icon,
      TextEditingController controller, bool isPassword) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      width: 300,
      decoration: BoxDecoration(
        color: const Color(0xFFFFAA00),
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
              obscureText: isPassword ? !_showPassword : false,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: const TextStyle(color: Colors.black, fontSize: 18),
                suffixIcon: isPassword
                    ? IconButton(
                        icon: Icon(
                          _showPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          setState(() {
                            _showPassword = !_showPassword;
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

  // Register Button Widget (Optional, can be used if you want a registration process)
  Widget buildRegisterButton(Size size) {
    return GestureDetector(
      onTap: () {
        // You can place registration logic here if needed
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        width: 300,
        decoration: BoxDecoration(
          color: const Color(0xFF173156),
          borderRadius: BorderRadius.circular(50),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person_add, color: Colors.white),
            SizedBox(width: 20),
            Text(
              "Register",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  // Login Text Widget
  Widget buildLoginText() {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      },
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Already have an Account? ",
            style:
                TextStyle(color: Color.fromARGB(255, 92, 92, 92), fontSize: 14),
          ),
          Text(
            "Login",
            style: TextStyle(
                color: Color.fromARGB(255, 92, 92, 92),
                fontSize: 14,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
