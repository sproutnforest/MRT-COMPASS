import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'first_screen.dart';

class PasswordValidator {
  static bool isLongEnough(String password) => password.length >= 8;

  static bool hasUpperLowerCase(String password) {
    final upperCaseRegex = RegExp(r'[A-Z]');
    final lowerCaseRegex = RegExp(r'[a-z]');
    return upperCaseRegex.hasMatch(password) && lowerCaseRegex.hasMatch(password);
  }

  static bool hasSymbol(String password) {
    final symbolRegex = RegExp(r'[!@#\$&*~]');
    return symbolRegex.hasMatch(password);
  }
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _showPassword = false;
  bool isLongEnough = false;
  bool hasUpperLowerCase = false;
  bool hasSymbol = false;
  bool isTyping = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void checkPasswordCriteria(String password) {
    setState(() {
      isTyping = password.isNotEmpty;
      isLongEnough = PasswordValidator.isLongEnough(password);
      hasUpperLowerCase = PasswordValidator.hasUpperLowerCase(password);
      hasSymbol = PasswordValidator.hasSymbol(password);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          _buildBackground(size),
          _buildRegisterForm(size),
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

  Widget _buildRegisterForm(Size size) {
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
                "Register",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.w900),
              ),
            ),
            const SizedBox(height: 20),
            buildTextField("Your Email", Icons.email, emailController, false),
            const SizedBox(height: 15),
            buildTextField("Password", Icons.lock, passwordController, true),
            const SizedBox(height: 10),
            if (isTyping)
              PasswordCriteria(
                isLongEnough: isLongEnough,
                hasUpperLowerCase: hasUpperLowerCase,
                hasSymbol: hasSymbol,
              ),
            const SizedBox(height: 20),
            buildRegisterButton(size),
            const SizedBox(height: 55),
            _buildLoginText(),
          ],
        ),
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
              onChanged: (value) {
                if (isPassword) {
                  checkPasswordCriteria(value);
                }
              },
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

  Widget buildRegisterButton(Size size) {
    return GestureDetector(
      onTap: () {
        if (isLongEnough && hasUpperLowerCase && hasSymbol) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Registration Successful"),
                content: const Text("You have registered successfully!"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text("OK"),
                  ),
                ],
              );
            },
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Please meet all password requirements.")),
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
            Icon(Icons.person_add, color: Colors.white),
            SizedBox(width: 20),
            Text(
              "Register",
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginText() {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
      },
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Already have an Account? ",
            style: TextStyle(color: Color.fromARGB(255, 92, 92, 92), fontSize: 14),
          ),
          Text(
            "Login",
            style: TextStyle(color: Color.fromARGB(255, 92, 92, 92), fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class PasswordCriteria extends StatelessWidget {
  final bool isLongEnough;
  final bool hasUpperLowerCase;
  final bool hasSymbol;

  const PasswordCriteria({
    super.key,
    required this.isLongEnough,
    required this.hasUpperLowerCase,
    required this.hasSymbol,
  });

  Widget buildCriteriaRow(String criteria, bool isMet) {
    return Row(
      children: [
        Icon(isMet ? Icons.check : Icons.close, color: isMet ? Colors.green : Colors.red, size: 20),
        const SizedBox(width: 10),
        Text(criteria),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildCriteriaRow("At least 8 characters", isLongEnough),
        buildCriteriaRow("Contains upper and lower case letters", hasUpperLowerCase),
        buildCriteriaRow("Contains at least one symbol", hasSymbol),
      ],
    );
  }
}
