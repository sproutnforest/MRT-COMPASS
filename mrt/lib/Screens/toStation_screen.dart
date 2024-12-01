import 'package:flutter/material.dart';
import 'package:mrt/constant.dart';

class RouteFinderScreen extends StatefulWidget {
  @override
  _RouteFinderScreenState createState() => _RouteFinderScreenState();
}

class _RouteFinderScreenState extends State<RouteFinderScreen> {
  final List<String> stations = [
    'Lebak Bulus Grab',
    'Fatmawati Indomaret',
    'Cipete Raya',
    'Haji Nawi',
    'Blok A',
    'Blok M BCA',
    'ASEAN',
    'Senayan Mastercard'
  ];

  String? startStation;
  String? endStation;
  List<String> route = [];

  void findRoute() {
    setState(() {
      if (startStation != null && endStation != null) {
        int startIndex = stations.indexOf(startStation!);
        int endIndex = stations.indexOf(endStation!);

        if (startIndex < endIndex) {
          route = stations.sublist(startIndex, endIndex + 1);
        } else {
          route = stations.sublist(endIndex, startIndex + 1).reversed.toList();
        }
      }
    });
  }

  void swapStations() {
    setState(() {
      final temp = startStation;
      startStation = endStation;
      endStation = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cari Rute", style: TextStyle(fontFamily: 'serif')),
        foregroundColor: Colors.white,
        centerTitle: true,
        backgroundColor: kPrimaryColor,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(24),
            margin: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 33),
                      child: const Text(
                        "Dari Stasiun",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'serif',
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Transform.translate(
                          offset: const Offset(0, -15),
                          child: const Icon(Icons.location_on,
                              color: kPrimaryHoverColor),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            underline: SizedBox(),
                            icon: SizedBox(),
                            value: startStation,
                            hint: const Text(
                              "Pilih Stasiun Keberangkatan",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                                fontFamily: 'serif',
                              ),
                            ),
                            items: stations.map((station) {
                              return DropdownMenuItem(
                                value: station,
                                child: Text(station,
                                    style: TextStyle(fontFamily: 'serif')),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                startStation = value;
                              });
                            },
                            dropdownColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Divider(
                        indent: 28,
                        endIndent: 50,
                        thickness: 1,
                        color: Colors.grey.shade300),
                    SizedBox(height: 12),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 32),
                      child: const Text(
                        "Ke Stasiun",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'serif',
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Transform.translate(
                          offset: Offset(0, -15),
                          child: Icon(Icons.location_on, color: Colors.red),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            underline: SizedBox(),
                            icon: SizedBox(),
                            value: endStation,
                            hint: const Text(
                              "Pilih Stasiun Tujuan",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 14,
                                  fontFamily: 'serif'),
                            ),
                            items: stations.map((station) {
                              return DropdownMenuItem(
                                value: station,
                                child: Text(station,
                                    style: TextStyle(fontFamily: 'serif')),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                endStation = value;
                              });
                            },
                            dropdownColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: findRoute,
                        child: const Text(
                          "Cari Rute",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'serif'),
                        ),
                      ),
                    ),
                  ],
                ),
                // Swap Button
                Positioned(
                  top: 54,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 240, 247, 255),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.swap_vert,
                          color: const Color.fromARGB(255, 6, 14, 100)),
                      onPressed: (startStation != null && endStation != null)
                          ? swapStations
                          : null,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Output Route
          if (route.isNotEmpty)
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: ListView.builder(
                  itemCount: route.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.circle,
                            color: Color.fromARGB(255, 38, 42, 133),
                            size: 12,
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                color: kSecondaryColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                route[index],
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'serif',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}