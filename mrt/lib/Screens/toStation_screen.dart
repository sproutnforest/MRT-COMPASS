import 'package:flutter/material.dart';
import 'package:mrt/constant.dart';

class RouteFinderScreen extends StatefulWidget {
  final String? startStation;
  final String? endStation;

  RouteFinderScreen({Key? key, this.startStation, this.endStation})
      : super(key: key);

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

  @override
  void initState() {
    super.initState();
    startStation = widget.startStation;
    endStation = widget.endStation;
  }

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
        title: Text("Cari Rute"),
        foregroundColor: Colors.white,
        centerTitle: true,
        backgroundColor: kPrimaryColor, // Teks judul putih
      ),
      body: Column(
        children: [
          // Container for Search Feature
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
                    // Text "Dari Stasiun" with Padding to move it to the right
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 33),
                      child: Text(
                        "Dari Stasiun",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Starting Station Dropdown
                    Row(
                      children: [
                        Transform.translate(
                          offset: Offset(0, -15), // Memberikan jarak ke atas
                          child: Icon(Icons.location_on,
                              color: kPrimaryHoverColor),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            underline: SizedBox(), // Remove underline
                            icon: SizedBox(), // Remove dropdown icon
                            value: startStation,
                            hint: Text(
                              "Pilih Stasiun Keberangkatan",
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 14),
                            ),
                            items: stations.map((station) {
                              return DropdownMenuItem(
                                value: station,
                                child: Text(station),
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
                    // Text "Ke Stasiun" with Padding to move it to the right
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 32),
                      child: Text(
                        "Ke Stasiun",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Destination Station Dropdown
                    Row(
                      children: [
                        Transform.translate(
                          offset: Offset(0, -15), // Memberikan jarak ke atas
                          child: Icon(Icons.location_on, color: Colors.red),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            underline: SizedBox(), // Remove underline
                            icon: SizedBox(), // Remove dropdown icon
                            value: endStation,
                            hint: Text(
                              "Pilih Stasiun Tujuan",
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 14),
                            ),
                            items: stations.map((station) {
                              return DropdownMenuItem(
                                value: station,
                                child: Text(station),
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
                    // Button to find route
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
                        child: Text(
                          "Cari Rute",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
                // Swap Button Positioned in the Middle Right
                Positioned(
                  top: 54, // Aligns with the middle of the dropdowns
                  right: 0, // Sticks to the right side
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
                          Icon(
                            Icons.circle,
                            color: const Color.fromARGB(255, 38, 42, 133),
                            size: 12,
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                color: kSecondaryColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                route[index],
                                style: TextStyle(color: Colors.black),
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
