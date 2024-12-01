import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:mrt/Screens/home_screen.dart';
import 'package:mrt/Screens/profile_screen.dart';
import 'dart:math';
import 'package:mrt/Screens/ticket.dart';
import 'package:mrt/Screens/ticket_screen_history.dart';
import 'package:mrt/constant.dart';

class LocationService {
  late double lat;
  late double lng;
  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }
    Position currentPosition = await Geolocator.getCurrentPosition();
    lat = currentPosition.latitude;
    lng = currentPosition.longitude;
  }

  double calculateDistance(double x1, double y1, double x2, double y2) {
    return sqrt(pow(x2 - x1, 2) + pow(y2 - y1, 2));
  }

  Future<String> getNearestStation() async {
    await getCurrentLocation();
    String station = "";
    double userlat = lat;
    double userlng = lng;
    double lebakbulus =
        calculateDistance(lng, lat, 106.77372397468612, -6.288449463606254);
    double fatmawati =
        calculateDistance(lng, lat, 106.79245999431001, -6.292215381227934);
    if (lebakbulus > fatmawati) {
      double cipeteraya =
          calculateDistance(lng, lat, 106.79728980780207, -6.278115290794062);
      if (fatmawati > cipeteraya) {
        double hajinawi = calculateDistance(
            lng, lat, 106.79738633848939, -6.2663826812490235);
        if (cipeteraya > hajinawi) {
          double bloka = calculateDistance(
              lng, lat, 106.79715615198145, -6.255486669878268);
          if (hajinawi > bloka) {
            double blokm = calculateDistance(
                lng, lat, 106.7980570789656, -6.2442353596941915);
            if (bloka > blokm) {
              double asean = calculateDistance(
                  lng, lat, 106.7985872366373, -6.238490322423835);
              if (blokm > asean) {
                double senayan = calculateDistance(
                    lng, lat, 106.80242375012944, -6.226463289595715);
                if (asean > senayan) {
                  double istora = calculateDistance(
                      lng, lat, 106.80858869430904, -6.222190643628549);
                  if (senayan > istora) {
                    double bendunganhilir = calculateDistance(
                        lng, lat, 106.81800363848866, -6.214744014981914);
                    if (istora > bendunganhilir) {
                      double setiabudi = calculateDistance(
                          lng, lat, 106.82148457105872, -6.208383834140822);
                      if (bendunganhilir > setiabudi) {
                        double dukuhatas = calculateDistance(
                            lng, lat, 106.82236642855631, -6.199687608944984);
                        if (setiabudi > dukuhatas) {
                          double bundaranhi = calculateDistance(
                              lng, lat, 106.82297685198046, -6.191667968783277);
                          if (dukuhatas > bundaranhi) {
                            station = "Bundaran HI";
                          } else {
                            station = "Dukuh Atas BNI";
                          }
                        } else {
                          station = "Setiabudi Astra";
                        }
                      } else {
                        station = "Bendungan Hilir";
                      }
                    } else {
                      station = "Istora Mnadiri";
                    }
                  } else {
                    station = "Senayan";
                  }
                } else {
                  station = "ASEAN";
                }
              } else {
                station = "Blok M BCA";
              }
            } else {
              station = "Blok A";
            }
          } else {
            station = "Haji Nawi";
          }
        } else {
          station = "Cipete Raya";
        }
      } else {
        station = "Fatmawati Indomaret";
      }
    } else {
      station = "Lebak Bulus Grab";
    }
    return station;
  }
}

class LocationWidget extends StatefulWidget {
  const LocationWidget({super.key});
  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  LocationService locationService = LocationService();
  String nearestStation = "Fetching nearest station...";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _updateNearestStation();
  }

  Future<void> _updateNearestStation() async {
    setState(() {
      isLoading = true;
    });

    try {
      String station = await locationService.getNearestStation();
      setState(() {
        nearestStation = station;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        nearestStation = 'Error: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Stasiun terdekat:"),
              const SizedBox(height: 25),
              isLoading
                  ? const CircularProgressIndicator()
                  : Text(
                      nearestStation,
                      style: const TextStyle(fontSize: 30),
                    ),
              const SizedBox(height: 25),
              SizedBox(
                width: 170,
                child: ElevatedButton(
                  onPressed: _updateNearestStation,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFAA00),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: const Text(
                    'Cari lagi',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
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
              // Navigate to Home (currently on Home page)
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
    );
  }
}
