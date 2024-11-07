import 'package:flutter/material.dart';
import 'package:mrt/constant.dart'; // Pastikan kPrimaryColor ada di sini

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Image.asset(
          'assets/logo.png', // Ganti dengan path logo Anda
          height: 30,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Bagian Selamat Datang
          Container(
            color: Colors.blue.shade900,
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Selamat datang teman MRT Compass!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Mau ke mana kita hari ini?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildLocationCard('Tujuan Kamu', 'Set lokasi Anda', Icons.location_on, Colors.blue.shade800),
                    _buildLocationCard('Hello, Budi', 'Saldo: Rp. 100.000', Icons.account_balance_wallet, Colors.green.shade800),
                  ],
                ),
              ],
            ),
          ),
          
          SizedBox(height: 20),
          
          // Tombol Beli Tiket
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green, // Mengganti primary dengan backgroundColor
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              // Tambahkan aksi beli tiket
            },
            child: Text(
              'Beli Tiket',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
          
          SizedBox(height: 20),
          
          // Bagian Informasi
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              padding: EdgeInsets.all(10),
              children: [
                _buildInfoCard('Arah MRT', 'assets/icon_direction.png'), // Ganti dengan ikon yang sesuai
                _buildInfoCard('Jadwal', 'assets/icon_schedule.png'),
                _buildInfoCard('Panduan', 'assets/icon_guide.png'),
              ],
            ),
          ),
        ],
      ),
      
      // Navigasi Bawah
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.train), label: 'Train'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        selectedItemColor: Colors.blue,
      ),
    );
  }

  Widget _buildLocationCard(String title, String subtitle, IconData icon, Color color) {
    return Card(
      color: color,
      child: Container(
        width: 150,
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.white, size: 30),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              subtitle,
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String imagePath) {
    return Card(
      elevation: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            height: 50,
            width: 50,
          ),
          SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}