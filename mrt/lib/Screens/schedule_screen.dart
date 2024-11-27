import 'package:flutter/material.dart';

import '/constant.dart';
import '../data/station_schedule_data.dart'; // Pastikan data stasiun diimpor
import '../models/station_schedule.dart';
import 'feed_screen.dart'; // Import Feed screen (Create this if needed)
import 'profile_screen.dart'; // Import the profile screen here
import 'ticket_screen.dart';


class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  String selectedStation = 'Bundaran HI Bank DKI'; // Default station

  // Method untuk mendapatkan jadwal berdasarkan stasiun dan arah
  List<String> getSchedule(String stationName, String direction) {
    final station = stationSchedules.firstWhere(
      (s) => s.stationName == stationName,
      orElse: () => StationSchedule(stationName: '', schedules: {}),
    );
    return station.schedules[direction] ?? ["--:--"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'JADWAL',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: kPrimaryColor,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Jadwal Keberangkatan Dari',
                    style: TextStyle(fontSize: 14, color: Colors.grey)),
                ElevatedButton(
                  onPressed: () {
                    _showModalBottomSheet(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kSecondaryColor,
                    side: const BorderSide(color: Colors.black, width: 1),
                  ),
                  child: const Text(
                    'UBAH',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              selectedStation,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const Divider(
              thickness: 1,
              color: Colors.black,
            ),
            const SizedBox(height: 70),
            Row(
              children: [
                // Kolom jadwal ke arah Lebak Bulus
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.directions_subway,
                                size: 20, color: Colors.blue),
                            SizedBox(width: 8),
                            Text(
                              'Ke arah Lebak Bulus',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          getSchedule(selectedStation, 'Lebak Bulus')[0],
                          style:
                              const TextStyle(fontSize: 32, color: Colors.blue),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Keberangkatan selanjutnya',
                          textAlign: TextAlign.center,
                        ),
                        ...getSchedule(selectedStation, 'Lebak Bulus')
                            .skip(1)
                            .map((time) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.blue.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(9.0),
                                      child: Text(
                                        time,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                )),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Kolom jadwal ke arah Bundaran HI
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.directions_subway,
                                size: 20, color: Colors.green),
                            SizedBox(width: 8),
                            Text(
                              'Ke arah Bundaran HI',
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          getSchedule(selectedStation, 'Bundaran HI')[0],
                          style: const TextStyle(
                              fontSize: 32, color: Colors.green),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Keberangkatan selanjutnya',
                          textAlign: TextAlign.center,
                        ),
                        ...getSchedule(selectedStation, 'Bundaran HI')
                            .skip(1)
                            .map((time) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.green.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(9.0),
                                      child: Text(
                                        time,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kPrimaryColor,
        type: BottomNavigationBarType.fixed, // Tambahkan ini

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.feed), label: 'Feed'), // Added Feed icon
          BottomNavigationBarItem(
              icon: Icon(Icons.confirmation_number),
              label: 'Ticket'), // Added Ticket icon
          BottomNavigationBarItem(
            icon: CircleAvatar(
              radius: 12,
              backgroundImage: AssetImage('assets/profile_image.png'),
            ),
            label: '',
          ),
        ],
        selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
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
                MaterialPageRoute(
                    builder: (context) =>
                        const FeedScreen()), // Navigate to Feed Screen
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const TicketHistoryScreen()), // Navigate to Ticket Screen
              );
              break;
            case 3:
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

  // Fungsi untuk menampilkan modal bottom sheet
  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: bluelight,
      builder: (BuildContext context) {
        return Column(
          children: [
            // Bagian atas modal dengan icon close dan teks
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(
                          context); // Menutup modal jika ikon close ditekan
                    },
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "Pilih Stasiun",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const Divider(),
            // Daftar stasiun
            Expanded(
              child: ListView(
                children: stationSchedules.map((station) {
                  bool isSelected = station.stationName ==
                      selectedStation; // Mengecek apakah stasiun dipilih

                  return ListTile(
                    title: Text(station.stationName),
                    trailing: isSelected
                        ? const Icon(Icons.check_circle,
                            color:
                                tertiaryColor) // Menampilkan tanda checklist jika dipilih
                        : null,
                    onTap: () {
                      setState(() {
                        selectedStation =
                            station.stationName; // Memilih stasiun
                      });
                      Navigator.pop(
                          context); // Menutup modal setelah memilih stasiun
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}

