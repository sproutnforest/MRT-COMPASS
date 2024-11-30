import 'package:flutter/material.dart';
import 'package:mrt/Screens/Ticket/ticket_screen.dart';

class TicketPurchaseScreen extends StatefulWidget {
  const TicketPurchaseScreen({super.key});

  @override
  _TicketPurchaseScreenState createState() => _TicketPurchaseScreenState();
}

class _TicketPurchaseScreenState extends State<TicketPurchaseScreen> {
  bool isSekaliJalanSelected = false;
  bool isPergiPulangSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: const Color(0xFF173156),
        title: const Text('Beli Tiket',
            style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TicketScreen(),
              ),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pembelian Tiket',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Stasiun Section
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(36, 158, 158, 158),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Dari Stasiun',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward,
                      size: 24, color: Colors.black54),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Ke Stasiun',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Jumlah Tiket Section
            const Text(
              'Jumlah Tiket',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                    _CounterButton(icon: Icons.remove, onPressed: () {}),
                    Container(
                      width: 50,
                      alignment: Alignment.center,
                      child: const Text(
                        '1',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    _CounterButton(icon: Icons.add, onPressed: () {}),
                  ],
                )),
            const SizedBox(height: 24),
            // Pilihan Perjalanan Section
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
                        isPergiPulangSelected =
                            false; // Jika Sekali Jalan dipilih, matikan Pergi Pulang
                      }
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
                      if (isSelected) {
                        isSekaliJalanSelected =
                            false; // Jika Pergi Pulang dipilih, matikan Sekali Jalan
                      }
                    });
                  },
                ),
              ],
            ),
            const Spacer(),
            // Rincian Pembelian Section
            const Divider(),
            const Text(
              'Rincian Pembelian',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Harga Tiket',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const Text(
                      'Rp 6.000',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Tiket',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const Text(
                      'Rp 6.000',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
              ],
            ),

            Center(
              child: Column(
                children: [
                  TextButton(
                    onPressed: () {
                      // Menampilkan BottomSheet
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.white,
                        isScrollControlled:
                            true, // Agar BottomSheet dapat menyesuaikan tinggi
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
                                          icon: const Icon(Icons.cancel_outlined))
                                    ],
                                  ),
                                  const Text(
                                    'Syarat dan Ketentuan Pembelian Tiket MRT Indonesia',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
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
                                    style: TextStyle(fontSize: 14),
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
                    onPressed: () {},
                    child: const Text(
                      'Bayar',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
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

  const _CounterButton({super.key, required this.icon, required this.onPressed});

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
    super.key,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  _TravelOptionState createState() => _TravelOptionState();
}

class _TravelOptionState extends State<_TravelOption> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          // Mengubah status isSelected saat di-tap
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
              SizedBox(
                height: 120,
                child: Image.asset(widget.icon),
              ),
              const SizedBox(height: 8),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
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
