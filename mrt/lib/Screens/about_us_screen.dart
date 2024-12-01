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
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(50)),
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
                  const Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .center,
                          children: [
                            Text(
                              "Visi",
                              style: TextStyle(
                                fontFamily: 'serif',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Mengubah mobilitas perkotaan dengan menyediakan alternatif transportasi yang modern dan ramah lingkungan, serta memastikan kenyamanan, aksesibilitas, dan keamanan bagi setiap orang.",
                              style: TextStyle(
                                fontFamily: 'serif',
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                          width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .center,
                          children: [
                            Text(
                              "Misi",
                              style: TextStyle(
                                fontFamily: 'serif',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Meningkatkan mobilitas perkotaan dengan solusi transportasi yang berkelanjutan dan inovatif, memberdayakan komunitas untuk terhubung dengan dunia di sekitar mereka.",
                              style: TextStyle(
                                fontFamily: 'serif',
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    "Meet the Team",
                    style: TextStyle(
                      fontFamily: 'serif',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: [
                      _buildTeamMember('Eryca'),
                      _buildTeamMember('Brenda'),
                      _buildTeamMember('Mayceren'),
                      _buildTeamMember('Chela'),
                      _buildTeamMember('Georgia'),
                      _buildTeamMember('Lusy'),
                    ],
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

  Widget _buildTeamMember(String name) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade300, Colors.blue.shade700],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(
              12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Text(
              name,
              style: const TextStyle(
                fontFamily: 'serif',
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color:
                    Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}