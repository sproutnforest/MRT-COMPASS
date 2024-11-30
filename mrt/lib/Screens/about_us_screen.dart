import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Tentang MRT COMPASS",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "MRT COMPASS adalah aplikasi transportasi pintar yang dirancang untuk memudahkan perjalanan Anda dengan sistem MRT (Mass Rapid Transit). Aplikasi ini menawarkan kemudahan dalam membeli tiket digital, mengetahui jadwal real-time, serta mendapatkan informasi penting terkait perjalanan Anda.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              "Misi Kami",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            const Text(
              "Untuk memberikan solusi transportasi yang efisien, ramah pengguna, dan berbasis teknologi, agar setiap perjalanan dengan MRT menjadi lebih nyaman dan mudah.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            const Text(
              "Visi Kami",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Menjadi aplikasi utama yang memudahkan pengguna dalam merencanakan perjalanan mereka dengan sistem transportasi MRT.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Tindakan saat menekan tombol
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Terima kasih telah membaca About Us!")));
              },
              child: const Text("Kembali ke Halaman Utama"),
            ),
          ],
        ),
      ),
    );
  }
}
