import 'package:flutter/material.dart';

import '/constant.dart';
import 'home_screen.dart';
import 'profile_screen.dart'; // Import the profile screen here
import 'ticket.dart';

class StationDetailScreen extends StatelessWidget {
  final Map<String, dynamic> stationData;

  const StationDetailScreen({super.key, required this.stationData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // top Navbar
      appBar: AppBar(
        title: const Text(
          'INFO PINTU KELUAR',
          style: TextStyle(
            color: kPrimaryLightColor,
            fontFamily: 'serif',
          ),
        ),
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: kPrimaryLightColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      //informasi stasiun
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.directions_subway, size: 40),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stationData['name'] ??
                          'Unknown Station',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          fontFamily: 'serif'),
                    ),
                    const Text(
                      'Daftar Pintu Keluar Pada Stasiun',
                      style: TextStyle(fontFamily: 'serif'),
                    ),
                  ],
                ),
              ],
            ),
            const Divider(thickness: 1),
            const SizedBox(height: 8),
            const Text(
              'Pintu Keluar',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'serif'),
            ),
            const SizedBox(height: 4),
            const Text(
              'Daftar Pintu Keluar Pada Stasiun',
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: (stationData['exits'] as Map<String, dynamic>)
                    .entries
                    .map<Widget>((entry) {
                  String exitName = entry.key;
                  Map<String, dynamic> exitData = entry.value;
                  String address = exitData['address'];
                  List<String> exitLocations =
                      List<String>.from(exitData['locations']);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        exitName,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'serif'),
                      ),
                      Text(
                        address,
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.grey,
                            fontFamily: 'serif'),
                      ),
                      ...exitLocations.map((location) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            location,
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontFamily: 'serif'),
                          ),
                        );
                      }).toList(),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),

      //bottom navbar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kPrimaryColor,
        type: BottomNavigationBarType.fixed,

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.confirmation_number), label: 'Ticket'),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              radius: 12,
              backgroundImage: AssetImage('assets/profile_image.png'),
            ),
            label: '',
          ),
        ],
        selectedItemColor: kPrimaryLightColor,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          // Handle bottom navigation actions here
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TicketScreen()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const ProfileScreen()), // Navigate to Profile Screen
              );
              break;
          }
        },
      ),
    );
  }
}
