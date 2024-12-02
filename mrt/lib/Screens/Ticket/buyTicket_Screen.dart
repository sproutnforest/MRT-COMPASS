import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mrt/Screens/Ticket/ticket_screen.dart';
import 'package:mrt/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TicketPurchaseScreen extends StatefulWidget {
  @override
  _TicketPurchaseScreenState createState() => _TicketPurchaseScreenState();
}

class _TicketPurchaseScreenState extends State<TicketPurchaseScreen> {
  bool isSekaliJalanSelected = false;
  bool isPergiPulangSelected = false;
  String selectedStation = "Dari Stasiun";
  String selectedStationTo = "Ke Stasiun";
  int _counter = 1;
  int totalPrice = 0;
  int hargaPerTikets = 0;

  void _increment() {
    setState(() {
      _counter++;
      _calculatePrice();
    });
  }

  void _decrement() {
    setState(() {
      if (_counter > 1) {
        _counter--;
        _calculatePrice();
      }
    });
  }

  Future<void> _calculatePrice() async {
    if (selectedStation != "Dari Stasiun" &&
        selectedStationTo != "Ke Stasiun") {
      final stationSnapshot = await FirebaseFirestore.instance
          .collection('station')
          .where('nama', whereIn: [selectedStation, selectedStationTo]).get();

      if (stationSnapshot.docs.length == 2) {
        final int jarakKeberangkatan = stationSnapshot.docs
                .firstWhere((doc) => doc['nama'] == selectedStation)['jarak']
            as int;
        final int jarakTujuan = stationSnapshot.docs
                .firstWhere((doc) => doc['nama'] == selectedStationTo)['jarak']
            as int;

        final int hargaPerTiket =
            (jarakTujuan - jarakKeberangkatan).abs() * 3000;
        final int perjalananFactor = isPergiPulangSelected ? 2 : 1;

        setState(() {
          totalPrice = hargaPerTiket * _counter * perjalananFactor;
          hargaPerTikets = hargaPerTiket;
        });
      }
    }
  }

  void _submitTransaction() async {
    if (selectedStation == "Dari Stasiun" ||
        selectedStationTo == "Ke Stasiun") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Pilih stasiun keberangkatan dan tujuan.")),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final uid = prefs.getString('uid');
    try {
      final now = Timestamp.now();
      await FirebaseFirestore.instance.collection('riwayat_transaksi').add({
        'stasiun_berangkat': selectedStation,
        'stasiun_tujuan': selectedStationTo,
        'uid': uid,
        'harga': totalPrice ~/ (isPergiPulangSelected ? 2 : 1),
        'qty': _counter,
        'status': "aktif",
        'created_at': now,
      });

      if (isPergiPulangSelected) {
        await FirebaseFirestore.instance.collection('riwayat_transaksi').add({
          'stasiun_berangkat': selectedStationTo,
          'stasiun_tujuan': selectedStation,
          'uid': uid,
          'harga': totalPrice ~/ 2,
          'qty': _counter,
          'status': "aktif",
          'created_at': now,
        });
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Transaksi berhasil ditambahkan.")),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TicketScreen(),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Terjadi kesalahan: $e")),
      );
    }
  }

  void _showStationPicker(BuildContext context) async {
    final stationsSnapshot = await FirebaseFirestore.instance
        .collection('station')
        .orderBy('jarak')
        .get();

    final stations = stationsSnapshot.docs
        .where((station) => station['nama'] != selectedStationTo)
        .toList();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: stations.length,
          itemBuilder: (context, index) {
            final station = stations[index];
            final stationName = station['nama'];

            return ListTile(
              title: Text(stationName),
              onTap: () {
                setState(() {
                  selectedStation = stationName;
                });
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }

  void _showStationPickerTo(BuildContext context) async {
    final stationsSnapshot = await FirebaseFirestore.instance
        .collection('station')
        .orderBy('jarak')
        .get();

    final stations = stationsSnapshot.docs
        .where((station) => station['nama'] != selectedStation)
        .toList();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: stations.length,
          itemBuilder: (context, index) {
            final station = stations[index];
            final stationName = station['nama'];

            return ListTile(
              title: Text(stationName),
              onTap: () {
                setState(() {
                  selectedStationTo = stationName;
                });
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Beli Tiket',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pembelian Tiket',
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'serif',
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(36, 158, 158, 158),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _showStationPicker(context),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          selectedStation,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward,
                      size: 24, color: Colors.black54),
                  const SizedBox(width: 8),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _showStationPickerTo(context),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          selectedStationTo,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Jumlah Tiket',
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'serif',
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(36, 158, 158, 158),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _CounterButton(icon: Icons.remove, onPressed: _decrement),
                    Container(
                      width: 50,
                      alignment: Alignment.center,
                      child: Text(
                        '$_counter',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    _CounterButton(icon: Icons.add, onPressed: _increment),
                  ],
                )),
            const SizedBox(height: 24),
            const Text(
              'Pilihan Perjalanan',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _TravelOption(
                  icon: 'assets/train-station.png',
                  label: 'Sekali Jalan',
                  isSelected: isSekaliJalanSelected,
                  onSelected: (isSelected) {
                    setState(() {
                      isSekaliJalanSelected = isSelected;
                      if (isSelected) {
                        isPergiPulangSelected = false;
                      }
                      _calculatePrice();
                    });
                  },
                ),
                const SizedBox(width: 16),
                _TravelOption(
                  icon: 'assets/train-station-out.png',
                  label: 'Pergi Pulang',
                  isSelected: isPergiPulangSelected,
                  onSelected: (isSelected) {
                    setState(() {
                      isPergiPulangSelected = isSelected;
                      _calculatePrice();
                      if (isSelected) {
                        isSekaliJalanSelected = false;
                      }
                    });
                  },
                ),
              ],
            ),
            const Spacer(),
            const Divider(),
            const Text(
              'Rincian Pembelian',
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'serif',
                  fontWeight: FontWeight.bold),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Harga Tiket',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'serif',
                      ),
                    ),
                    Text(
                      'Rp ${hargaPerTikets.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'serif',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Harga',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'serif',
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Rp ${totalPrice.toStringAsFixed(0)}',
                      style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'serif',
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
            Center(
              child: Column(
                children: [
                  TextButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.white,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Spacer(),
                                      IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon:
                                              const Icon(Icons.cancel_outlined))
                                    ],
                                  ),
                                  const Text(
                                    'Syarat dan Ketentuan Pembelian Tiket MRT Indonesia',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'serif',
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  const Text(
                                    '1. Tiket MRT hanya berlaku untuk perjalanan yang tertera pada tiket.'
                                    '\n2. Pembelian tiket dilakukan melalui aplikasi resmi atau mesin tiket.'
                                    '\n3. Tiket tidak dapat dipindahtangankan atau dikembalikan.'
                                    '\n4. Penumpang wajib mengikuti peraturan yang berlaku di dalam kereta dan stasiun.'
                                    '\n5. Penumpang bertanggung jawab atas barang bawaan pribadi.'
                                    '\n\nBaca lebih lanjut di website kami.',
                                    style: TextStyle(
                                        fontSize: 14, fontFamily: 'serif'),
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: const Text(
                      'Baca syarat dan ketentuan kami',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'serif',
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: _submitTransaction,
                    child: const Text(
                      'Bayar',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'serif',
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CounterButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _CounterButton({Key? key, required this.icon, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, size: 24, color: Colors.black),
      onPressed: onPressed,
    );
  }
}

class _TravelOption extends StatefulWidget {
  final String label;
  final String icon;
  final bool isSelected;
  final Function(bool) onSelected;

  const _TravelOption({
    Key? key,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onSelected,
  }) : super(key: key);

  @override
  _TravelOptionState createState() => _TravelOptionState();
}

class _TravelOptionState extends State<_TravelOption> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          widget.onSelected(!widget.isSelected);
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(
              color: widget.isSelected ? Colors.blue : Colors.grey.shade400,
            ),
            borderRadius: BorderRadius.circular(8),
            color: widget.isSelected
                ? Colors.blue.withOpacity(0.2)
                : Colors.transparent,
          ),
          child: Column(
            children: [
              Container(
                height: 120,
                child: Image.asset(widget.icon),
              ),
              const SizedBox(height: 8),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'serif',
                  color: widget.isSelected ? Colors.blue : Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
