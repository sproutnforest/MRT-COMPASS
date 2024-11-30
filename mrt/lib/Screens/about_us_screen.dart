import 'package:flutter/material.dart';
import "package:mrt/constant.dart";

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Us"),
        foregroundColor: Colors.white,
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        automaticallyImplyLeading: true,
      ),
      body: Container(
        color: const Color.fromARGB(255, 255, 255, 255),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              child: Transform.translate(
                offset: const Offset(0, 0),
                child: Image.asset(
                  'assets/longtrain.png',
                  width: 500,
                  height: 500,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                width: MediaQuery.of(context).size.width * 1.3,
                height: MediaQuery.of(context).size.height * 0.05,
                decoration: const BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(50)),
                  child: Image.asset(
                    'assets/pt1.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  _buildHeader("About Us"),
                  const SizedBox(height: 16),
                  _buildContentText(
                    "MRT COMPASS adalah penyedia layanan transportasi yang inovatif dan dapat diandalkan, berkomitmen untuk membuat pengalaman perjalanan Anda lancar dan efisien. Kami bertujuan tidak hanya untuk memenuhi, tetapi melebihi harapan Anda dengan menawarkan layanan cepat, berkualitas, serta teknologi mutakhir.",
                  ),
                  const SizedBox(height: 30),
                  _buildSectionTitle("Visi & Misi"),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _buildContentText(
                              "Visi: Mengubah mobilitas perkotaan dengan menyediakan alternatif transportasi yang modern dan ramah lingkungan, serta memastikan kenyamanan, aksesibilitas, dan keamanan bagi setiap orang.",
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _buildContentText(
                              "Misi: Meningkatkan mobilitas perkotaan dengan solusi transportasi yang berkelanjutan dan inovatif, memberdayakan komunitas untuk terhubung dengan dunia di sekitar mereka.",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  _buildSectionTitle("Tim Kami"),
                  const SizedBox(height: 20),
                  // Menampilkan anggota tim secara manual
                  _buildTeamMember("Eryca 1", 'assets/person1.jpg'),
                  const SizedBox(height: 20),
                  _buildTeamMember("Eryca 2", 'assets/person2.jpg'),
                  const SizedBox(height: 20),
                  _buildTeamMember("Eryca 3", 'assets/person3.jpg'),
                  const SizedBox(height: 20),
                  _buildTeamMember("Eryca 4", 'assets/person4.jpg'),
                  const SizedBox(height: 20),
                  _buildTeamMember("Eryca 5", 'assets/person5.jpg'),
                  const SizedBox(height: 20),
                  _buildTeamMember("Eryca 6", 'assets/person6.jpg'),
                  const SizedBox(height: 40),
                  _buildSectionTitle("Connect With Us"),
                  const SizedBox(height: 10),
                  _buildTextField("Masukkan alamat email Anda"),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Anda telah terdaftar untuk menerima pembaruan!")));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kSecondaryColor,
                    ),
                    child: const Text("Daftar"),
                  ),
                  const SizedBox(height: 30),
                  _buildFooter(),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'serif',
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildContentText(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'serif',
        fontSize: 14,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'serif',
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildFooter() {
    return const Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(bottom: 100.0),
        child: Column(
          children: [],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 11.5),
      child: TextField(
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  // Menampilkan anggota tim secara manual
  Widget _buildTeamMember(String name, String imagePath) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            imagePath, // Path gambar anggota tim
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          name, // Nama anggota tim
          style: const TextStyle(
            fontFamily: 'serif',
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}