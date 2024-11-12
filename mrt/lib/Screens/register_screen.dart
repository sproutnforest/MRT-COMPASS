import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'package:mrt/constant.dart';

class PasswordValidator {
  static bool isLongEnough(String password) => password.length >= 8;

  static bool hasUpperLowerCase(String password) {
    final upperCaseRegex = RegExp(r'[A-Z]');
    final lowerCaseRegex = RegExp(r'[a-z]');
    return upperCaseRegex.hasMatch(password) &&
        lowerCaseRegex.hasMatch(password);
  }

  static bool hasSymbol(String password) {
    final symbolRegex = RegExp(r'[!@#\$&*~]');
    return symbolRegex.hasMatch(password);
  }
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool showPassword = false;
  bool isLongEnough = false;
  bool hasUpperLowerCase = false;
  bool hasSymbol = false;
  bool isTyping = false;

  @override
  void dispose() {
    nameController.dispose();
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
          buildBackground(size),
          buildRegisterForm(size),
        ],
      ),
    );
  }

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
                'assets/longtrain.png',
                fit: BoxFit.contain,
                width: size.width,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildRegisterForm(Size size) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 0),
            Transform.translate(
              offset: const Offset(0, 50),
              child: const Text(
                "Sign Up",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.w900),
              ),
            ),
            const SizedBox(height: 20),
            Transform.translate(
              offset: const Offset(0, 50),
              child:
                  buildTextField("Name", Icons.person, nameController, false),
            ),
            const SizedBox(height: 20),
            Transform.translate(
              offset: const Offset(0, 50),
              child:
                  buildTextField("Email", Icons.email, emailController, false),
            ),
            const SizedBox(height: 15),
            Transform.translate(
              offset: const Offset(0, 50),
              child: buildTextField(
                  "Password", Icons.lock, passwordController, true),
            ),
            const SizedBox(height: 10),
            if (isTyping)
              Transform.translate(
                offset: const Offset(40, 53),
                child: PasswordCriteria(
                  isLongEnough: isLongEnough,
                  hasUpperLowerCase: hasUpperLowerCase,
                  hasSymbol: hasSymbol,
                ),
              ),
            const SizedBox(height: 20),
            buildRegisterButton(size),
            const SizedBox(height: 55),
            buildLoginText(),
          ],
        ),
      ),
    );
  }

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

  Widget buildRegisterButton(Size size) {
    return Transform.translate(
      offset: const Offset(0, 40),
      child: GestureDetector(
        onTap: () {
          if (isLongEnough && hasUpperLowerCase && hasSymbol) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Sign Up Successful"),
                  content: const Text("You Have Sign Up Successfully!"),
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
              const SnackBar(
                  content: Text("Please meet all password requirements.")),
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          width: 300,
          decoration: BoxDecoration(
        color:kPrimaryColor,
        borderRadius: BorderRadius.circular(50),
      ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.person_add, color: Colors.white),
              SizedBox(width: 20),
              Text(
                "Sign Up",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
            "Sign In",
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
        Icon(isMet ? Icons.check : Icons.close,
            color: isMet ? Colors.green : Colors.red, size: 20),
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
        buildCriteriaRow(
            "Contains uppercase and lowercase letters", hasUpperLowerCase),
        buildCriteriaRow("Contains a symbol (!@#\$&*~)", hasSymbol),
      ],
    );
  }
}
