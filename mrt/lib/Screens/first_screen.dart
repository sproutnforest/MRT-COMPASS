import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'register_screen.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Layer longtrain.png dan rmh2.png di belakang
          Positioned(
            child: Transform.translate(
              offset: const Offset(80, -330),
              child: Image.asset(
                'assets/rmh2.png',
                width: 320,
                height: 320,
              ),
            ),
          ),
          Positioned(
            child: Transform.translate(
              offset: const Offset(0, -330),
              child: Image.asset(
                'assets/longtrain.png',
                width: 500,
                height: 500,
              ),
            ),
          ),
          // Layer pt1.png di atas longtrain.png dan rmh2.png
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: MediaQuery.of(context).size.width * 1.3,
              height: MediaQuery.of(context).size.height * 0.4697,
              decoration: const BoxDecoration(
                color: Color(0xFF173156),
                borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(50)),
                child: Image.asset(
                  'assets/pt1.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 500,
            right: -60,
            child: Transform.rotate(
              angle: 45 * 3.141592653589793238 / 180,
              child: Image.asset(
                'assets/tangga.png',
                width: 250,
                height: 520,
              ),
            ),
          ),
          // Konten utama dengan tombol Login dan Register
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 20, right: 50, left: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 140),
                          child: Text(
                            'Welcome!',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w700,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 380),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFAA00),
                    padding: const EdgeInsets.symmetric(horizontal: 110, vertical: 20),
                    textStyle: const TextStyle(fontSize: 25),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      side: const BorderSide(
                        color: Color.fromARGB(255, 0, 0, 0),
                        width: 1,
                      ),
                    ),
                    elevation: 5,
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 23),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegisterScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFAA00),
                    padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                    textStyle: const TextStyle(fontSize: 25),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      side: const BorderSide(
                        color: Color.fromARGB(255, 0, 0, 0),
                        width: 1,
                      ),
                    ),
                    elevation: 5,
                  ),
                  child: const Text(
                    'Register',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
