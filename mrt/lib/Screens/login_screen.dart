import 'package:flutter/material.dart';
import 'first_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Transform.translate(
                  offset: Offset(-155, 440),
                  child: Image.asset(
                    'assets/rmh2.png',
                    fit: BoxFit.contain,
                    width: size.width * 0.9,
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
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FirstScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text("Back"),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text("Next"),
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.translate(
                    offset: Offset(-90, -110),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  buildTextField("Email", Icons.email, emailController),
                  const SizedBox(height: 15),
                  buildTextField("Password", Icons.lock, passwordController),
                  const SizedBox(height: 20),
                  buildLoginButton(size),
                  const SizedBox(height: 15),
                  const Text(
                    "Don’t have an Account? Register",
                    style: TextStyle(
                      color: Color.fromARGB(255, 92, 92, 92),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextField(String hintText, IconData icon, TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      width: 300,
      decoration: BoxDecoration(
        color: Color(0xFFFFAA00),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Icon(icon, color: const Color.fromARGB(255, 0, 0, 0)),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: const TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 18,
                ),
              ),
              obscureText: hintText == "Password" ? true : false,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLoginButton(Size size) {
    return GestureDetector(
      onTap: () {
        String email = emailController.text;
        String password = passwordController.text;
        print("Email: $email, Password: $password");
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        width: 300,
        decoration: BoxDecoration(
          color: Color(0xFF173156),
          borderRadius: BorderRadius.circular(50),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.login, color: Colors.white),
            SizedBox(width: 10),
            Text(
              "Login",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
