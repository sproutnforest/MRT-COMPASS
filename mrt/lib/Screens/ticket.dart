import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mrt/Screens/Ticket/buyTicket_Screen.dart';
import 'package:mrt/Screens/home_screen.dart';
import 'package:mrt/Screens/profile_screen.dart';
import 'package:mrt/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TicketScreen extends StatefulWidget {
  const TicketScreen({Key? key}) : super(key: key);

  @override
  State<TicketScreen> createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> {
  int _currentIndex = 1;
  String? uid;

  void _onTabTapped(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
        break;
      case 1:
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
        break;
    }

    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUid();
  }

  Future<void> _loadUid() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = prefs.getString('uid');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Tiket',
          style: TextStyle(
            color: kPrimaryLightColor,
            fontFamily: 'serif',
          ),
        ),
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.local_activity_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              // Tambahkan aksi untuk ikon ini
            },
          ),
        ],
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
      body: Column(
        children: [
          const Spacer(),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('riwayat_transaksi')
                .where('uid', isEqualTo: uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return const Center(child: Text("Terjadi kesalahan"));
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 180,
                      child: Center(child: Image.asset('assets/maskot.png')),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Tidak ada tiket aktif',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'serif',
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Untuk dapat menggunakan tiket kamu perlu membelinya terlebih dahulu',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'serif',
                          color: Colors.grey),
                    ),
                  ],
                );
              }

              final data = snapshot.data!.docs;

              return SizedBox(
                  height: MediaQuery.sizeOf(context).width,
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final transaksi = data[index];
                      return GestureDetector(
                          onTap: () {
                            _showQRCodeBottomSheet(context, transaksi.id);
                          },
                          child: Container(
                              color: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: Colors.blue)),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset(
                                            'assets/tr1.png',
                                            height: 50,
                                          ),
                                          Text(
                                            "ID. ${transaksi.id}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        "Tujuan ${transaksi['stasiun_berangkat'] ?? 'Reguler'}",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'serif',
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Berangkat Dari: ${transaksi['stasiun_tujuan'] ?? 'Reguler'}",
                                            style: const TextStyle(
                                                color: Colors.grey),
                                          ),
                                          Text(
                                            "Harga: ${transaksi['harga'] ?? '0'}",
                                            style: const TextStyle(
                                                color: Colors.green),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        "Status tiket: ${transaksi['status'] ?? 'Kadaluarsa'}",
                                        style: TextStyle(
                                          color: transaksi['status'] == 'aktif'
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )));
                    },
                  ));
            },
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TicketPurchaseScreen(),
                  ),
                );
              },
              child: const Text(
                'Beli Tiket',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'serif',
                    color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void _showQRCodeBottomSheet(BuildContext context, String transactionId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "QR Code Tiket",
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'serif',
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Image.network(
                "https://api.qrserver.com/v1/create-qr-code/?size=250x250&data=$transactionId",
                height: 250,
                width: 250,
              ),
            ],
          ),
        );
      },
    );
  }
}
