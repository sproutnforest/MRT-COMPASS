import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
        userPoints = 1; // Set a default value when the user is not logged in
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
        userPoints = 1; // Set a default value when the user is not logged in
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Color buttonColor1 =
        buttonValue1 > userPoints ? Colors.grey : const Color(0xFFFFAA00);
    Color buttonColor2 =
        buttonValue2 > userPoints ? Colors.grey : const Color(0xFFFFAA00);
    Color buttonColor3 =
        buttonValue3 > userPoints ? Colors.grey : const Color(0xFFFFAA00);

    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            // The existing blue container section
            Container(
              width: double.infinity,
              height: 350,
              color: Colors.blue,
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
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '${userPoints.toString()}',
                            style: TextStyle(
                              color: const Color(0xFFFFAA00),
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
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
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: ElevatedButton(
                      onPressed: buttonColor1 == Colors.grey
                          ? null
                          : () {
                              // Add your action for when the button is clicked here
                              print('Button 1 pressed');
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
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: ElevatedButton(
                      onPressed: buttonColor2 == Colors.grey
                          ? null
                          : () {
                              // Add your action for when the button is clicked here
                              print('Button 2 pressed');
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
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: ElevatedButton(
                      onPressed: buttonColor3 == Colors.grey
                          ? null
                          : () {
                              // Add your action for when the button is clicked here
                              print('Button 3 pressed');
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
      ),
    );
  }
}
