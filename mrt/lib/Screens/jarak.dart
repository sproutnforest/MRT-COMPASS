import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Estimasi Waktu Perjalanan',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const EstimasiWaktuScreen(),
    );
  }
}

class EstimasiWaktuScreen extends StatefulWidget {
  const EstimasiWaktuScreen({Key? key}) : super(key: key);

  @override
  _EstimasiWaktuScreenState createState() => _EstimasiWaktuScreenState();
}

class _EstimasiWaktuScreenState extends State<EstimasiWaktuScreen> {
  final Map<String, int> jarakAntarStasiun = {
    'Dukuh Atas': 0,
    'Bundaran HI': 15,
    'Sudirman': 20, 
    'Setiabudi': 25,
    'Bendungan Hilir': 30, 
    'Fatmawati': 75, 
    'Lebak Bulus': 90,
  };

  final int kecepatanKereta = 80;
  String? stasiunAsal;
  String? stasiunTujuan;
  String? estimasiWaktu;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estimasi Waktu Perjalanan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: stasiunAsal,
              hint: const Text('Pilih Stasiun Asal'),
              isExpanded: true,
              items: jarakAntarStasiun.keys
                  .map((stasiun) => DropdownMenuItem<String>(
                        value: stasiun,
                        child: Text(stasiun),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  stasiunAsal = value;
                  estimasiWaktu = null;
                });
              },
            ),
            const SizedBox(height: 16),
            DropdownButton<String>(
              value: stasiunTujuan,
              hint: const Text('Pilih Stasiun Tujuan'),
              isExpanded: true,
              items: jarakAntarStasiun.keys
                  .where((stasiun) => stasiun != stasiunAsal)
                  .map((stasiun) => DropdownMenuItem<String>(
                        value: stasiun,
                        child: Text(stasiun),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  stasiunTujuan = value;
                  estimasiWaktu = null;
                });
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _hitungEstimasiWaktu,
              child: const Text('Hitung Estimasi Waktu'),
            ),
            const SizedBox(height: 16),
            if (estimasiWaktu != null)
              Text(
                estimasiWaktu!,
                style: const TextStyle(fontSize: 18, fontFamily: 'serif', fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }

  void _hitungEstimasiWaktu() {
    if (stasiunAsal == null || stasiunTujuan == null) {
      setState(() {
        estimasiWaktu = 'Pilih stasiun asal dan tujuan terlebih dahulu.';
      });
      return;
    }

    int jarak = (jarakAntarStasiun[stasiunTujuan!]! - jarakAntarStasiun[stasiunAsal!]!).abs();

    double waktuPerjalanan = jarak / kecepatanKereta;

    int jam = waktuPerjalanan.floor();
    int menit = ((waktuPerjalanan - jam) * 60).round();

    setState(() {
      estimasiWaktu = 'Estimasi waktu perjalanan: $jam jam $menit menit';
    });
  }
}
