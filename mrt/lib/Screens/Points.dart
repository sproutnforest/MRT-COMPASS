import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mrt/Screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:mrt/Screens/profile_screen.dart';
import 'package:mrt/Screens/ticket.dart';
import 'package:mrt/constant.dart';

class Points extends StatefulWidget {
  @override
  _PointsState createState() => _PointsState();
}

class _PointsState extends State<Points> {
  int userPoints = 2;
  int buttonValue1 = 2000;
  int buttonValue2 = 4000;
  int buttonValue3 = 7000;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void addPoints(int many) async {
    var user = FirebaseAuth.instance.currentUser;

    if (user != null && user.email != null) {
      String email = user.email!;
      print('User email: $email');

      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('Users');
      try {
        QuerySnapshot querySnapshot =
            await usersCollection.where('email', isEqualTo: email).get();
        if (querySnapshot.docs.isNotEmpty) {
          DocumentSnapshot document = querySnapshot.docs.first;
          int currentPoints = document['points'];
          int newPoints = currentPoints + many;
          await document.reference.update({'points': newPoints});
          print('User points updated to: $newPoints');
          setState(() {
            userPoints = newPoints;
          });
        } else {
          print('User document not found.');
          setState(() {
            userPoints = 1;
          });
        }
      } catch (e) {
        print('Error fetching user data: $e');
        setState(() {
          userPoints = 1;
        });
      }
    } else {
      print('No user is currently logged in or user email is null.');
      setState(() {
        userPoints = 1;
      });
    }
  }

  void removePoints(int many) async {
    var user = FirebaseAuth.instance.currentUser;

    if (user != null && user.email != null) {
      String email = user.email!;
      print('User email: $email');

      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('Users');
      try {
        QuerySnapshot querySnapshot =
            await usersCollection.where('email', isEqualTo: email).get();
        if (querySnapshot.docs.isNotEmpty) {
          DocumentSnapshot document = querySnapshot.docs.first;
          int currentPoints = document['points'];
          int newPoints = currentPoints - many;
          await document.reference.update({'points': newPoints});
          print('User points updated to: $newPoints');
          setState(() {
            userPoints = newPoints;
          });
        } else {
          print('User document not found.');
          setState(() {
            userPoints = 1;
          });
        }
      } catch (e) {
        print('Error fetching user data: $e');
        setState(() {
          userPoints = 1;
        });
      }
    } else {
      print('No user is currently logged in or user email is null.');
      setState(() {
        userPoints = 1;
      });
    }
  }

  void _loadUserData() async {
    var user = FirebaseAuth.instance.currentUser;

    if (user != null && user.email != null) {
      String email = user.email!;
      print('User email: $email');

      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('Users');
      try {
        QuerySnapshot querySnapshot =
            await usersCollection.where('email', isEqualTo: email).get();
        if (querySnapshot.docs.isNotEmpty) {
          DocumentSnapshot document = querySnapshot.docs.first;
          String userID = document.id;
          print('Document data: ${document.data()}');
          setState(() {
            userPoints = document['points'];
          });
          print('User points updated to: $userPoints');
        } else {
          print('User document not found.');
          setState(() {
            userPoints = 1;
          });
        }
      } catch (e) {
        print('Error fetching user data: $e');
        setState(() {
          userPoints = 1;
        });
      }
    } else {
      print('No user is currently logged in or user email is null.');
      setState(() {
        userPoints = 1;
      });
    }
  }

  void addTickets(int manytickets, int points) async {
    var user = FirebaseAuth.instance.currentUser;
    String userID = "unknown";

    if (user != null) {
      userID = user.uid; // Get the current user's ID
    }

    CollectionReference ticketsCollection =
        FirebaseFirestore.instance.collection('riwayat_transaksi');
    CollectionReference ticketscollection =
        FirebaseFirestore.instance.collection('riwayat_transaksi');
    try {
      DocumentReference documentRef = await ticketscollection.add({
        'created_at': FieldValue.serverTimestamp(),
        'harga': 0,
        'qty': manytickets,
        'stasiun_berangkat': "Kemana aja",
        'stasiun_tujuan': "Kemana aja",
        'status': "aktif",
        'uid': userID,
      });
      removePoints(points);
      print('Document added with ID: ${documentRef.id}');
    } catch (e) {
      print('Error adding document: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Color buttonColor1 =
        buttonValue1 > userPoints ? Colors.grey : kSecondaryColor;
    Color buttonColor2 =
        buttonValue2 > userPoints ? Colors.grey : kSecondaryColor;
    Color buttonColor3 =
        buttonValue3 > userPoints ? Colors.grey : kSecondaryColor;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(CupertinoIcons.back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: kPrimaryHoverColor,
        ),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: 275,
              color: kPrimaryHoverColor,
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 45.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'My MRT-points',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontFamily: 'serif',
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '${userPoints.toString()}',
                            style: TextStyle(
                              color: kSecondaryColor,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'serif',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Padding(
                    padding: const EdgeInsets.only(right: 35.0),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/profile_image.png'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: Text(
                'Reward',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'serif',
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Text(
                      '1 tiket gratis kemana aja',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'serif',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: ElevatedButton(
                      onPressed: buttonColor1 == Colors.grey
                          ? null
                          : () {
                              addTickets(1, 2000);
                            },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 10.0),
                        backgroundColor: buttonColor1,
                      ),
                      child: Text(
                        '${buttonValue1.toString()}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'serif',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Text(
                      '3 tiket gratis kemana aja',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'serif',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: ElevatedButton(
                      onPressed: buttonColor2 == Colors.grey
                          ? null
                          : () {
                              addTickets(3, 4000);
                            },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 10.0),
                        backgroundColor: buttonColor2,
                      ),
                      child: Text(
                        '${buttonValue2.toString()}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'serif',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Text(
                      '5 tiket gratis kemana aja',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: 'serif',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: ElevatedButton(
                      onPressed: buttonColor3 == Colors.grey
                          ? null
                          : () {
                              addTickets(5, 7000);
                            },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 10.0),
                        backgroundColor: buttonColor3,
                      ),
                      child: Text(
                        '${buttonValue3.toString()}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'serif',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
      ),
    );
  }
}
