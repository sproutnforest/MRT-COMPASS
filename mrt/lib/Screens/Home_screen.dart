import 'package:flutter/material.dart';
import 'package:mrt/constant.dart'; // Ensure this is where your colors and constants are defined
import 'profile_screen.dart'; // Import the profile screen here
import 'feed_screen.dart'; // Import Feed screen (Create this if needed)
import 'ticket_screen.dart'; // Import Ticket screen (Create this if needed)

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 0, // Hide app bar for custom top section
      ),
      body: Column(
        children: [
          // Top Points Section - Make this clickable to navigate to Profile
          GestureDetector(
            onTap: () {
              // Navigate to Profile Screen when Points are tapped
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()), // ProfileScreen
              );
            },
            child: Container(
              color: Colors.green,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: const Center(
                child: Text(
                  '96000 Points',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          // Welcome Section
          Container(
            color: kPrimaryColor,
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
                      'Kemana kita hari ini?',
                      Icons.directions,
                      Colors.blue.shade800,
                    ),
                    _buildLocationCard(
                      'Halte & Rute',
                      'Telusuri Halte dan Rute',
                      Icons.map,
                      Colors.orange.shade800,
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
              backgroundColor: Colors.green,
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

      // Bottom Navigation with 4 Items (Home, Feed, Ticket, Profile)
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.feed), label: 'Feed'), // Added Feed icon
          BottomNavigationBarItem(icon: Icon(Icons.confirmation_number), label: 'Ticket'), // Added Ticket icon
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Profile'),
        ],
        selectedItemColor: kPrimaryColor,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          // Handle bottom navigation actions here
          switch (index) {
            case 0:
              // Navigate to Home (currently on Home page)
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FeedScreen()), // Navigate to Feed Screen
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  TicketHistoryScreen()), // Navigate to Ticket Screen
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()), // Navigate to Profile Screen
              );
              break;
          }
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