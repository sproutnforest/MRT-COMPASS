import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'package:mrt/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
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

  // Fungsi registrasi dengan Firebase Auth
  Future<void> registerWithEmailPassword() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),password: passwordController.text.trim(), );
 //memperbarui nama tampilan pengguna yang sedang masuk di Firebase Authentication
      await FirebaseAuth.instance.currentUser!.updateDisplayName(nameController.text.trim());
      await FirebaseAuth.instance.currentUser!.reload();

      //Menyimpan Data Pengguna di Firestore
      await _firestore.collection('Users').add({ 
        'email': emailController.text.trim(),
        'name': nameController.text.trim(),
        'password': passwordController.text.trim(),
        'points': 0,
        'profil': "",
        'saldo': 0,
        'timestamp': FieldValue.serverTimestamp(),
      });
      // Navigasi ke layar login
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'weak-password') {
        errorMessage = 'Kata sandi terlalu lemah.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'Email sudah terdaftar.';
      } else {
        errorMessage = 'Terjadi kesalahan. Coba lagi.';
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorMessage)));
    }
  }

  @override
  Widget build(BuildContext context) {
    // Semua widget berada di sini
    return Scaffold(
      body: Stack(
        children: [
          buildBackground(MediaQuery.of(context).size),
          buildRegisterForm(MediaQuery.of(context).size),
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
            const Text(
              "Sign Up",
              style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Serif'),
            ),
            const SizedBox(height: 20),
            buildTextField("Name", Icons.person, nameController, false),
            const SizedBox(height: 20),
            buildTextField("Email", Icons.email, emailController, false),
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
            buildRegisterButton(),
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

  Widget buildRegisterButton() {
    return GestureDetector(
      onTap: () {
        if (isLongEnough && hasUpperLowerCase && hasSymbol) {
          registerWithEmailPassword();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text("Mohon penuhi semua persyaratan kata sandi.")),
          );
        }
      },
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
            Icon(Icons.person_add, color: Colors.white),
            SizedBox(width: 20),
            Text(
              "Sign Up",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Serif',
                  fontWeight: FontWeight.bold),
            ),
          ],
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
                fontFamily: 'Serif',
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