import 'package:flutter/material.dart';
import 'package:mrt/constant.dart';

import '../data/station_data.dart'; // Import data stasiun
import 'station_detail_screen.dart';

class StationDetailHomeScreen extends StatefulWidget {
  const StationDetailHomeScreen({super.key});

  @override
  _StationDetailHomeScreenState createState() =>
      _StationDetailHomeScreenState();
}

class _StationDetailHomeScreenState extends State<StationDetailHomeScreen> {
  // Menyimpan daftar semua stasiun
  List<Map<String, dynamic>> filteredStations = stations;

  // Fungsi untuk memfilter stasiun berdasarkan teks pencarian
  void _filterStations(String query) {
    final results = stations.where((station) {
      final nameLower = station['name'].toLowerCase();
      final queryLower = query.toLowerCase();
      return nameLower.contains(queryLower);
    }).toList();

    setState(() {
      filteredStations = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PANDUAN PINTU KELUAR',
          style: TextStyle(
            color: kPrimaryLightColor,
            fontFamily: 'serif',
          ),
        ),
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: kPrimaryLightColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari stasiun',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              onChanged: _filterStations,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredStations.length,
              itemBuilder: (context, index) {
                final station = filteredStations[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: kPrimaryLightColor,
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: kPrimaryHoverColor,
                        child: Icon(
                          Icons.train,
                          color: kPrimaryLightColor,
                        ),
                      ),
                      title: Text(
                        station['name'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'serif',
                        ),
                      ),
                      trailing: Icon(Icons.chevron_right),
                      onTap: () {
                        // Navigasi ke halaman detail stasiun
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                StationDetailScreen(stationData: station),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
