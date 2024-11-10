import 'package:flutter/material.dart';
import 'package:mrt/Screens/Home_screen.dart';

import 'change_pass_screen.dart';
import 'edit_profile_screen.dart';
import 'feed_screen.dart';
import 'login_screen.dart';
import 'ticket_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = "Don Key";
  String email = "donkey1@example.com";
  int _selectedIndex = 3;

  void updateProfile(String newName, String newEmail) {
    setState(() {
      name = newName;
      email = newEmail;
    });
  }

  void _showLogoutConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            child: Text('Yes'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PROFIL"),
        foregroundColor: Colors.white,
        centerTitle: true,
        backgroundColor: Color(0xFF173156),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/profile_image.png'),
          ),
          const SizedBox(height: 10),
          Text(
            name,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text(
            email,
            style: TextStyle(color: Colors.grey[600]),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfileScreen(
                    currentName: name,
                    currentEmail: email,
                  ),
                ),
              );

              if (result != null) {
                updateProfile(result['name'], result['email']);
              }
            },
            child: Text("Edit Profil", style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              minimumSize: Size(130, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                ProfileOptionTile(
                  icon: Icons.lock,
                  text: "Ubah Password",
                  backgroundColor: Colors.orange,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => change_pass_screen(),
                      ),
                    );
                  },
                ),
                ProfileOptionTile(
                  icon: Icons.emoji_emotions,
                  text: "MRT-points",
                  backgroundColor: Colors.orange,
                ),
                ProfileOptionTile(
                  icon: Icons.favorite,
                  text: "Favorit",
                  backgroundColor: Colors.orange,
                ),
                ProfileOptionTile(
                  icon: Icons.history,
                  text: "History",
                  backgroundColor: Colors.orange,
                ),
                ProfileOptionTile(
                  icon: Icons.logout,
                  text: "Logout",
                  textColor: Colors.red,
                  backgroundColor: const Color.fromARGB(255, 172, 40, 31),
                  onTap: _showLogoutConfirmation,
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.feed), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.confirmation_number), label: ''),
          BottomNavigationBarItem(
            icon: CircleAvatar(
              radius: 12,
              backgroundImage: AssetImage('assets/profile_image.png'),
            ),
            label: '',
          ),
        ],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
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
                MaterialPageRoute(builder: (context) => const FeedScreen()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TicketHistoryScreen()),
              );
              break;
            case 3:
              break;
          }
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xFF173156),
      ),
    );
  }
}

class ProfileOptionTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onTap;
  final Color? iconColor;
  final Color backgroundColor;
  final double iconSize;
  final Color textColor;

  ProfileOptionTile(
      {required this.icon,
      required this.text,
      this.onTap,
      this.iconColor = Colors.white,
      this.backgroundColor = Colors.orange,
      this.iconSize = 18.0,
      this.textColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: iconSize,
        ),
      ),
      title: Text(text, style: TextStyle(color: textColor)),
      trailing: Icon(Icons.chevron_right, color: textColor),
      onTap: onTap,
    );
  }
}
