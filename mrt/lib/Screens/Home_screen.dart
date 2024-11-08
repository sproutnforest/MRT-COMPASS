import 'package:flutter/material.dart';
import 'package:mrt/constant.dart'; 

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Image.asset(
          'assets/logo.png', // Replace with the correct path for your logo
          height: 30,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Welcome Section
          Container(
            color: kPrimaryColor, // Replacing with your primary color constant
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Selamat datang teman MRT Compass!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Mau ke mana kita hari ini?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildLocationCard(
                      'Tujuan Kamu', 
                      'Set lokasi Anda', 
                      Icons.location_on, 
                      Colors.blue.shade800,
                    ),
                    _buildLocationCard(
                      'Hello, Budi', 
                      'Saldo: Rp. 100.000', 
                      Icons.account_balance_wallet, 
                      Colors.green.shade800,
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Ticket Purchase Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green, // Use backgroundColor instead of primary
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              // Add ticket purchase action here
            },
            child: const Text(
              'Beli Tiket',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Information Section with Grid
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              padding: const EdgeInsets.all(10),
              children: [
                _buildInfoCard('Arah MRT', 'assets/icon_direction.png'), // Replace with appropriate icon
                _buildInfoCard('Jadwal', 'assets/icon_schedule.png'),
                _buildInfoCard('Panduan', 'assets/icon_guide.png'),
              ],
            ),
          ),
        ],
      ),
      
      // Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.train), label: 'Train'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        selectedItemColor: kPrimaryColor,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          // Handle bottom navigation actions here
        },
      ),
    );
  }

  // Card for Location Information
  Widget _buildLocationCard(String title, String subtitle, IconData icon, Color color) {
    return Card(
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.white, size: 30),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              subtitle,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  // Card for Additional Information
  Widget _buildInfoCard(String title, String imagePath) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            height: 50,
            width: 50,
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}