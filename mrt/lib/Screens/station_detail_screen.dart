import 'package:flutter/material.dart';

import '/constant.dart';

class StationDetailScreen extends StatelessWidget {
  final Map<String, dynamic> stationData;

  const StationDetailScreen({super.key, required this.stationData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Bottom Navbar
      appBar: AppBar(
        title: const Text(
          'INFO PINTU KELUAR',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
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
                          'Unknown Station', // Beri nilai default jika null
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const Text('Daftar Pintu Keluar Pada Stasiun'),
                  ],
                ),
              ],
            ),
            const Divider(thickness: 1),
            const SizedBox(height: 8),
            const Text(
              'Pintu Keluar',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              'Daftar Pintu Keluar Pada Stasiun',
              style: TextStyle(fontSize: 16),
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
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        address,
                        style:
                            const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      ...exitLocations.map((location) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Text(
                            location,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.grey),
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
        type: BottomNavigationBarType.fixed,
        backgroundColor: kPrimaryColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.confirmation_number),
            label: 'Tickets',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: (index) {},
      ),
    );
  }
}
