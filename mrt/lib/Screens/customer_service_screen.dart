import 'package:flutter/material.dart';
import "package:mrt/constant.dart";

class CustomerServiceScreen extends StatelessWidget {
  const CustomerServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customer Service"),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Background Image
          Positioned(
            child: Transform.translate(
              offset: const Offset(0, 0),
              child: Image.asset(
                'assets/longtrain.png',
                width: 500,
                height: 500,
              ),
            ),
          ),
          
          // Container for main content
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: MediaQuery.of(context).size.width * 1.3,
              height: MediaQuery.of(context).size.height * 0.05,
              decoration: const BoxDecoration(
                color: kPrimaryColor, // Replace with kPrimaryColor if you have it defined
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

          // Main content inside the Container
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                // Header
                _buildHeader("Committed to You"),
                const SizedBox(height: 16),
                _buildContentText(
                  "Kami di MRT COMPASS berkomitmen untuk menyediakan layanan transportasi yang terbaik dan inovatif. Kami berusaha tidak hanya memenuhi harapan Anda, tetapi juga melebihi mereka. Kami menjamin layanan yang cepat, berkualitas, serta teknologi yang inovatif untuk pengalaman perjalanan yang lebih efisien dan nyaman.",
                ),
                const SizedBox(height: 30),

                // Help Section
                _buildSectionTitle("Need Help?"),
                const SizedBox(height: 10),
                _buildContentText(
                  "MRT COMPASS menawarkan dukungan pelanggan yang cepat dan ramah untuk memastikan perjalanan Anda berjalan lancar. Jika Anda memiliki pertanyaan tentang aplikasi atau perjalanan MRT, tim dukungan kami siap membantu Anda setiap saat.",
                ),
                const SizedBox(height: 30),

                // Support Contact Information
                _buildContentText("MRT COMPASS Customer Support – 800.123.4567"),
                const SizedBox(height: 20),
                _buildContentText("Support Regular Hours"),
                _buildContentText("Mon-Sat 6:00am-10:00pm, PST"),
                const SizedBox(height: 10),
                _buildContentText("Support After Hour Emergencies"),
                _buildContentText("Mon-Sat 10:00pm-12:00am, PST\nSunday 6:00am-6:00pm, PST"),
                const SizedBox(height: 40),

                // Contact Form (Send a Message) with White Background
                Container(
                  color:const Color.fromARGB(255, 243, 243, 243), // White background for the form
                  padding: const EdgeInsets.all(16.0), // Padding inside the container
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle("Send a Message"),
                      const SizedBox(height: 20),
                      _buildTextField("Name"),
                      _buildTextField("Company"),
                      _buildTextField("Phone"),
                      _buildTextField("Email"),
                      _buildTextField("Message", maxLines: 4),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Terima kasih telah menghubungi kami!")));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kSecondaryColor, // Set button color to kSecondaryColor
                        ),
                        child: const Text("Kirim Pesan"),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                // Footer
                _buildFooter(),

                // News & Updates
                _buildSectionTitle("The Latest"),
                const SizedBox(height: 10),
                _buildContentText(
                  "Pembaruan Terbaru: MRT COMPASS memperkenalkan sistem pemesanan tiket terbaru yang memungkinkan pengguna memesan tiket lebih cepat dan mudah.\n\nJadwal MRT baru saja diperbarui untuk memastikan perjalanan yang lebih tepat waktu dan efisien.",
                ),
                const SizedBox(height: 20),

                // Newsletter Signup
                _buildSectionTitle("Stay Up-to-Date"),
                _buildTextField("Enter your email address"),
                const SizedBox(height: 20),

                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Anda telah terdaftar untuk menerima berita!")));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kSecondaryColor, // Set button color to kSecondaryColor
                  ),
                  child: const Text("Daftar"),
                ),

                Padding(
                padding: const EdgeInsets.only(bottom: 200), // This will create space after the button
                child: Container(),  // Just an empty container to create spacing
              ),  // Add enough space for the logo to be visible
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper function to create a header text with larger style
  Widget _buildHeader(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

  // Helper function for content text, smaller size and normal style
  Widget _buildContentText(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 16),
      textAlign: TextAlign.justify,
    );
  }

  // Helper function for section title, bold and slightly larger
  Widget _buildSectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  // Helper function for the footer
  Widget _buildFooter() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "MRT COMPASS\nJl. Raya Transportasi No. 123\nJakarta, Indonesia\nToll Free: 800.123.4567\nEmail: support@mrtcompass.com",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  // Helper function to create text fields
  Widget _buildTextField(String label, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 11.5),
      child: TextField(
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
