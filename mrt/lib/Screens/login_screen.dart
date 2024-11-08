import 'package:flutter/material.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _showPassword = false;

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
          _buildBackground(size),
          _buildLoginForm(size),
        ],
      ),
    );
  }

  Widget _buildBackground(Size size) {
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
            angle: 45 * 3.14 / 180,
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

  Widget _buildLoginForm(Size size) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            Transform.translate(
              offset: const Offset(0, 0),
              child: const Text(
                "Login",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.w900),
              ),
            ),
            const SizedBox(height: 20),
            buildTextField("Email", Icons.email, emailController, false),
            const SizedBox(height: 15),
            buildTextField("Password", Icons.lock, passwordController, true),
            const SizedBox(height: 20),
            buildLoginButton(size),
            const SizedBox(height: 15),
            buildRegisterText(), 
          ],
        ),
      ),
    );
  }

  Widget buildRegisterText() {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreen()));
      },
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don't have an Account? ",
            style: TextStyle(color: Color.fromARGB(255, 92, 92, 92), fontSize: 14),
          ),
          Text(
            "Register",
            style: TextStyle(color: Color.fromARGB(255, 92, 92, 92), fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget buildTextField(String hintText, IconData icon, TextEditingController controller, bool isPassword) {
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
                          _showPassword ? Icons.visibility : Icons.visibility_off,
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

  Widget buildLoginButton(Size size) {
    return GestureDetector(
      onTap: () {
        String email = emailController.text;
        String password = passwordController.text;

        if (email.isEmpty || password.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Please fill in both fields")),
          );
        } else {
          // Simulate login success
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Login successful")),
          );
        }
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
            Icon(Icons.login, color: Colors.white),
            SizedBox(width: 20),
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
