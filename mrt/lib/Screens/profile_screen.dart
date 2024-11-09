import 'package:flutter/material.dart';
import 'edit_profile_screen.dart';
import 'change_pass_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = "Don Key";
  String email = "donkey1@example.com";

  // Fungsi untuk update profil
  void updateProfile(String newName, String newEmail) {
    setState(() {
      name = newName;
      email = newEmail;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PROFIL"),
        backgroundColor: Colors.blue[900],
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
          SizedBox(height: 20),
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
            child: Text("Edit Profil"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => change_pass_screen(),
                      ),
                    );
                  },
                ),
                ProfileOptionTile(icon: Icons.emoji_emotions, text: "MRT-points"),
                ProfileOptionTile(icon: Icons.favorite, text: "Favorit"),
                ProfileOptionTile(icon: Icons.history, text: "History"),
                ProfileOptionTile(
                  icon: Icons.logout,
                  text: "Logout",
                  iconColor: Colors.red,
                  onTap: () {
                    // Aksi logout
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.local_activity), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Profile'),
        ],
        selectedItemColor: Colors.blue[900],
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}

class ProfileOptionTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onTap;
  final Color? iconColor;

  ProfileOptionTile({
    required this.icon,
    required this.text,
    this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: iconColor ?? Colors.amber),
      title: Text(text),
      trailing: Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
