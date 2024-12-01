import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:mrt/Screens/profile_screen.dart';
import 'package:mrt/Screens/ticket.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'RoutesDetail.dart';
import 'package:mrt/constant.dart';

class Routes extends StatelessWidget {
  const Routes({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    SizedBox(
                      width: 375, // Control the width of the TextField
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFFE0E0E0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: 'Stasiun apa?',
                          hintText: 'Aku mau ke stasiun ',
                          suffixIcon: IconButton(
                            icon: const Icon(CupertinoIcons.search),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TimelineTile(
                      isFirst: true,
                      beforeLineStyle:
                          const LineStyle(color: Color(0xFF173156)),
                      indicatorStyle:
                          const IndicatorStyle(color: Color(0xFF173156)),
                      endChild: Container(
                        margin: const EdgeInsets.all(25),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RoutesDetail(
                                    routes: "Lebak Bulus Grab"),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xFFFFAA00), // Button color
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15), // Button size
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(5), // Rounded corners
                            ),
                          ),
                          child: const Text(
                            'Lebak Bulus Grab',
                            style: TextStyle(
                              fontSize: 18, // Text size
                              fontWeight: FontWeight.bold, // Bold text
                              color: Colors.white, // Text color
                            ),
                          ),
                        ),
                      ),
                    ),
                    TimelineTile(
                      beforeLineStyle:
                          const LineStyle(color: Color(0xFF173156)),
                      indicatorStyle:
                          const IndicatorStyle(color: Color(0xFF173156)),
                      endChild: Container(
                        margin: const EdgeInsets.all(25),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RoutesDetail(
                                    routes: "Fatmawati Indomaret"),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xFFFFAA00), // Button color
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15), // Button size
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(5), // Rounded corners
                            ),
                          ),
                          child: const Text(
                            'Fatmawati Indomaret',
                            style: TextStyle(
                              fontSize: 18, // Text size
                              fontWeight: FontWeight.bold, // Bold text
                              color: Colors.white, // Text color
                            ),
                          ),
                        ),
                      ),
                    ),
                    TimelineTile(
                      beforeLineStyle:
                          const LineStyle(color: Color(0xFF173156)),
                      indicatorStyle:
                          const IndicatorStyle(color: Color(0xFF173156)),
                      endChild: Container(
                        margin: const EdgeInsets.all(25),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const RoutesDetail(routes: "Cipete Raya"),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xFFFFAA00), // Button color
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15), // Button size
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(5), // Rounded corners
                            ),
                          ),
                          child: const Text(
                            'Cipete Raya',
                            style: TextStyle(
                              fontSize: 18, // Text size
                              fontWeight: FontWeight.bold, // Bold text
                              color: Colors.white, // Text color
                            ),
                          ),
                        ),
                      ),
                    ),
                    TimelineTile(
                      beforeLineStyle:
                          const LineStyle(color: Color(0xFF173156)),
                      indicatorStyle:
                          const IndicatorStyle(color: Color(0xFF173156)),
                      endChild: Container(
                        margin: const EdgeInsets.all(25),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const RoutesDetail(routes: "Haji Nawi"),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xFFFFAA00), // Button color
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15), // Button size
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(5), // Rounded corners
                            ),
                          ),
                          child: const Text(
                            'Haji Nawi',
                            style: TextStyle(
                              fontSize: 18, // Text size
                              fontWeight: FontWeight.bold, // Bold text
                              color: Colors.white, // Text color
                            ),
                          ),
                        ),
                      ),
                    ),
                    TimelineTile(
                      beforeLineStyle:
                          const LineStyle(color: Color(0xFF173156)),
                      indicatorStyle:
                          const IndicatorStyle(color: Color(0xFF173156)),
                      endChild: Container(
                        margin: const EdgeInsets.all(25),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const RoutesDetail(routes: "Blok A"),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xFFFFAA00), // Button color
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15), // Button size
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(5), // Rounded corners
                            ),
                          ),
                          child: const Text(
                            'Blok A',
                            style: TextStyle(
                              fontSize: 18, // Text size
                              fontWeight: FontWeight.bold, // Bold text
                              color: Colors.white, // Text color
                            ),
                          ),
                        ),
                      ),
                    ),
                    TimelineTile(
                      beforeLineStyle:
                          const LineStyle(color: Color(0xFF173156)),
                      indicatorStyle:
                          const IndicatorStyle(color: Color(0xFF173156)),
                      endChild: Container(
                        margin: const EdgeInsets.all(25),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const RoutesDetail(routes: "Blok M BCA"),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xFFFFAA00), // Button color
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15), // Button size
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(5), // Rounded corners
                            ),
                          ),
                          child: const Text(
                            'Blok M BCA',
                            style: TextStyle(
                              fontSize: 18, // Text size
                              fontWeight: FontWeight.bold, // Bold text
                              color: Colors.white, // Text color
                            ),
                          ),
                        ),
                      ),
                    ),
                    TimelineTile(
                      beforeLineStyle:
                          const LineStyle(color: Color(0xFF173156)),
                      indicatorStyle:
                          const IndicatorStyle(color: Color(0xFF173156)),
                      endChild: Container(
                        margin: const EdgeInsets.all(25),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const RoutesDetail(routes: "ASEAN"),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xFFFFAA00), // Button color
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15), // Button size
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(5), // Rounded corners
                            ),
                          ),
                          child: const Text(
                            'ASEAN',
                            style: TextStyle(
                              fontSize: 18, // Text size
                              fontWeight: FontWeight.bold, // Bold text
                              color: Colors.white, // Text color
                            ),
                          ),
                        ),
                      ),
                    ),
                    TimelineTile(
                      beforeLineStyle:
                          const LineStyle(color: Color(0xFF173156)),
                      indicatorStyle:
                          const IndicatorStyle(color: Color(0xFF173156)),
                      endChild: Container(
                        margin: const EdgeInsets.all(25),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const RoutesDetail(routes: "Senayan"),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xFFFFAA00), // Button color
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15), // Button size
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(5), // Rounded corners
                            ),
                          ),
                          child: const Text(
                            'Senayan',
                            style: TextStyle(
                              fontSize: 18, // Text size
                              fontWeight: FontWeight.bold, // Bold text
                              color: Colors.white, // Text color
                            ),
                          ),
                        ),
                      ),
                    ),
                    TimelineTile(
                      beforeLineStyle:
                          const LineStyle(color: Color(0xFF173156)),
                      indicatorStyle:
                          const IndicatorStyle(color: Color(0xFF173156)),
                      endChild: Container(
                        margin: const EdgeInsets.all(25),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RoutesDetail(
                                    routes: "Istora Mandiri"),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xFFFFAA00), // Button color
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15), // Button size
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(5), // Rounded corners
                            ),
                          ),
                          child: const Text(
                            'Istora Mandiri',
                            style: TextStyle(
                              fontSize: 18, // Text size
                              fontWeight: FontWeight.bold, // Bold text
                              color: Colors.white, // Text color
                            ),
                          ),
                        ),
                      ),
                    ),
                    TimelineTile(
                      beforeLineStyle:
                          const LineStyle(color: Color(0xFF173156)),
                      indicatorStyle:
                          const IndicatorStyle(color: Color(0xFF173156)),
                      endChild: Container(
                        margin: const EdgeInsets.all(25),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RoutesDetail(
                                    routes: "Bendungan Hilir"),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xFFFFAA00), // Button color
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15), // Button size
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(5), // Rounded corners
                            ),
                          ),
                          child: const Text(
                            'Bendungan Hilir',
                            style: TextStyle(
                              fontSize: 18, // Text size
                              fontWeight: FontWeight.bold, // Bold text
                              color: Colors.white, // Text color
                            ),
                          ),
                        ),
                      ),
                    ),
                    TimelineTile(
                      beforeLineStyle:
                          const LineStyle(color: Color(0xFF173156)),
                      indicatorStyle:
                          const IndicatorStyle(color: Color(0xFF173156)),
                      endChild: Container(
                        margin: const EdgeInsets.all(25),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RoutesDetail(
                                    routes: "Setiabudi Astra"),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xFFFFAA00), // Button color
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15), // Button size
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(5), // Rounded corners
                            ),
                          ),
                          child: const Text(
                            'Setiabudi Astra',
                            style: TextStyle(
                              fontSize: 18, // Text size
                              fontWeight: FontWeight.bold, // Bold text
                              color: Colors.white, // Text color
                            ),
                          ),
                        ),
                      ),
                    ),
                    TimelineTile(
                      beforeLineStyle:
                          const LineStyle(color: Color(0xFF173156)),
                      indicatorStyle:
                          const IndicatorStyle(color: Color(0xFF173156)),
                      endChild: Container(
                        margin: const EdgeInsets.all(25),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RoutesDetail(
                                    routes: "Dukuh Atas BNI"),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xFFFFAA00), // Button color
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15), // Button size
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(5), // Rounded corners
                            ),
                          ),
                          child: const Text(
                            'Dukuh Atas BNI',
                            style: TextStyle(
                              fontSize: 18, // Text size
                              fontWeight: FontWeight.bold, // Bold text
                              color: Colors.white, // Text color
                            ),
                          ),
                        ),
                      ),
                    ),
                    TimelineTile(
                      isLast: true,
                      beforeLineStyle:
                          const LineStyle(color: Color(0xFF173156)),
                      indicatorStyle:
                          const IndicatorStyle(color: Color(0xFF173156)),
                      endChild: Container(
                        margin: const EdgeInsets.all(25),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const RoutesDetail(routes: "Bundaran HI"),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xFFFFAA00), // Button color
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15), // Button size
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(5), // Rounded corners
                            ),
                          ),
                          child: const Text(
                            'Bundaran HI',
                            style: TextStyle(
                              fontSize: 18, // Text size
                              fontWeight: FontWeight.bold, // Bold text
                              color: Colors.white, // Text color
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.confirmation_number),
              label: 'Ticket'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: 'Profile'),
        ],
        selectedItemColor: kPrimaryColor,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          switch (index) {
            case 0:
              // Navigate to Home (currently on Home page)
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const TicketScreen()),
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
      ),
    );
  }
}
