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
  String selectedStation = 'Bundaran HI Bank DKI';

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
                                      padding: const EdgeInsets.all(8.0),
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
              icon: Icon(Icons.account_circle), label: 'Profile'),
        ],
        selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          // Handle bottom navigation actions here
          switch (index) {
            case 0:
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FeedScreen()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const TicketHistoryScreen()),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
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
      backgroundColor: lightblue,
      builder: (BuildContext context) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
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
            Expanded(
              child: ListView(
                children: stationSchedules.map((station) {
                  bool isSelected = station.stationName == selectedStation;

                  return ListTile(
                    title: Text(station.stationName),
                    trailing: isSelected
                        ? const Icon(Icons.check_circle, color: tertiaryColor)
                        : null,
                    onTap: () {
                      setState(() {
                        selectedStation = station.stationName;
                      });
                      Navigator.pop(context);
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
