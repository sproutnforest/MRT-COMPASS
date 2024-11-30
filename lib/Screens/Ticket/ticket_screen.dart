import 'package:flutter/material.dart';
import 'package:mrt/Screens/Ticket/buyTicket_Screen.dart';
import 'package:mrt/Screens/Ticket/iklan_screen.dart';
import 'package:mrt/Screens/home_screen.dart';
import 'package:mrt/Screens/profile_screen.dart';
import 'package:mrt/Screens/widget/custom_bottom_nav.dart';

class TicketScreen extends StatefulWidget {
  const TicketScreen({super.key});

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  int _currentIndex = 1;

  void _onTabTapped(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
        break;
      case 1:
        break; // Sudah di TicketScreen
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
        break;
    }

    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF173156),
        title: const Text('Tiket',
            style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.local_activity_outlined,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
      body: Column(
        children: [
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image Placeholder
              SizedBox(
                height: 180,
                child: Center(child: Image.asset('assets/maskot.png')),
              ),
              const SizedBox(height: 16),
              const Text(
                'Tidak ada tiket aktif',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Untuk dapat menggunakan tiket kamu perlu membelinya terlebih dahulu',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
          const Spacer(),
          // Button Beli Tiket
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                // Navigate to Ticket Purchase Screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TicketPurchaseScreen(),
                  ),
                );
              },
              child: const Text(
                'Beli Tiket',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Slider for Ads
          Row(
            children: [
              const Spacer(),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  const IklanScreen(),
                  ),
                );
                  },
                  child: const Text(
                    "View All",
                    style: TextStyle(color: Colors.black),
                  ))
            ],
          ),
          SizedBox(
            height: 150,
            child: PageView.builder(
              itemCount: 5,
              controller: PageController(viewportFraction: 0.9),
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.blue.shade100,
                  ),
                  child: Center(
                    child: Text(
                      'Iklan ${index + 1}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
