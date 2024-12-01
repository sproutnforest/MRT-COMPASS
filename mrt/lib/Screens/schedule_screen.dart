import 'dart:async'; // Untuk Timer

import 'package:flutter/material.dart';

import '/constant.dart';
import '../data/station_schedule_data.dart'; // Data stasiun
import '../models/station_schedule.dart';
import 'home_screen.dart';
import 'profile_screen.dart'; // Import the profile screen here
import 'ticket.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  String selectedStation = 'Bundaran HI Bank DKI'; // Default station
  Timer? _timer; // Timer untuk real-time updates

  @override
  void initState() {
    super.initState();
    // Inisialisasi Timer untuk update real-time
    _startRealTimeUpdates();
  }

  @override
  void dispose() {
    // Membatalkan Timer saat widget dihapus
    _timer?.cancel();
    super.dispose();
  }

  // Memulai pembaruan real-time
  void _startRealTimeUpdates() {
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      setState(() {
        print('Updating schedule for $selectedStation');
      });
    });
  }

  // Method untuk mendapatkan jadwal berdasarkan stasiun dan arah
  List<String> getSchedule(String stationName, String direction) {
    final station = stationSchedules.firstWhere(
      (s) => s.stationName == stationName,
      orElse: () => StationSchedule(stationName: '', schedules: {}),
    );

    // Ambil semua jadwal arah tertentu
    final allSchedules = station.schedules[direction] ?? [];

    // Ubah format jadwal ke DateTime
    final now = DateTime.now();
    final currentTime =
        DateTime(now.year, now.month, now.day, now.hour, now.minute);

    final filteredSchedules = allSchedules
        .map((time) {
          final parts = time.split(':');
          if (parts.length == 2) {
            final hour = int.tryParse(parts[0]) ?? 0;
            final minute = int.tryParse(parts[1]) ?? 0;
            return DateTime(now.year, now.month, now.day, hour, minute);
          }
          return null;
        })
        .where((schedule) => schedule != null && schedule.isAfter(currentTime))
        .cast<DateTime>()
        .take(7) // Ambil hanya 7 keberangkatan berikutnya
        .toList();

    // Konversi kembali ke format string
    return filteredSchedules
        .map((dt) =>
            "${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}")
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'JADWAL',
          style: TextStyle(
            fontFamily: 'serif',
            color: Colors.white,
          ),
        ),
        backgroundColor: kPrimaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: kPrimaryLightColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
      ),
      backgroundColor: kPrimaryLightColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: const Text('Jadwal Keberangkatan Dari',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'serif',
                            color: Colors.grey)),
                  ),
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
                        fontFamily: 'serif',
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                selectedStation,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  fontFamily: 'serif',
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
                    child: _buildScheduleColumn(
                      'Ke arah Lebak Bulus',
                      bluelight,
                      getSchedule(selectedStation, 'Lebak Bulus'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Kolom jadwal ke arah Bundaran HI
                  Expanded(
                    child: _buildScheduleColumn(
                      'Ke arah Bundaran HI',
                      Colors.green,
                      getSchedule(selectedStation, 'Bundaran HI'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.confirmation_number), label: 'Ticket'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle), label: 'Profile'),
          ],
          selectedItemColor: kPrimaryColor,
          unselectedItemColor: Colors.grey,
          onTap: (index) {
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

  // Widget untuk kolom jadwal
  Widget _buildScheduleColumn(
      String title, Color color, List<String> schedules) {
    while (schedules.length < 7) {
      schedules.add('--:--');
    }

    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.directions_subway, size: 20, color: color),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center, // Membuat teks tetap terpusat
                  softWrap: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            schedules.isNotEmpty ? schedules[0] : '--:--',
            style: TextStyle(fontSize: 35, color: color, fontFamily: 'serif'),
          ),
          const SizedBox(height: 8),
          const Text(
            'Keberangkatan selanjutnya',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'serif',
            ),
          ),
          // Menampilkan semua jadwal, termasuk placeholder
          ...schedules.skip(1).map((time) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
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
    );
  }

  // Fungsi untuk menampilkan modal bottom sheet
  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
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
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'serif',
                    ),
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
