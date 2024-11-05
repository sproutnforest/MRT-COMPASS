import 'package:flutter/material.dart';
import 'login_screen.dart'; // Import halaman login
import 'register_screen.dart'; // Import halaman register

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: MediaQuery.of(context).size.width * 1.3,
              height: MediaQuery.of(context).size.height * 1,
              decoration: const BoxDecoration(
                color: Color(0xFF173156),
                borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
              ),
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(50)),
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
              angle: 45 *
                  3.141592653589793238 /
                  180, 
              child: Image.asset(
                'assets/tangga.png',
                width: 250,
                height: 520,
              ),
            ),
          ),
          Positioned(
            bottom: -23,
            right: 3,
            child: Image.asset(
              'assets/longtrain.png',
              width: 500,
              height: 500,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                    bottom: 20,
                    right: 50,
                    left: 50,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: 150,
                          ),
                          child: Text(
                            'Hello!',
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.w800,
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontFamily: 'Montserrat',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 180),
                ElevatedButton(
                  onPressed: () {
                    // Navigasi ke halaman Login
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFFAA00),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 110, vertical: 20),
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
                    // Navigasi ke halaman Register
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 206, 165, 84),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100, vertical: 20),
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
