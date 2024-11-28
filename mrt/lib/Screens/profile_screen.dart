import 'package:flutter/material.dart';
import 'package:mrt/Screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'change_pass_screen.dart';
import 'edit_profile_screen.dart';
import 'feed_screen.dart';
import 'login_screen.dart';
import 'package:mrt/constant.dart';
import 'ticket_screen_history.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

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
        title: const Text('Logout'),
        content: const Text('Apakah Anda yakin ingin keluar?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            child: const Text('Ya'),
          ),
        ],
      ),
    );
  }

void _showDeleteAccountConfirmation(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Hapus Akun'),
      content: const Text('Apakah Anda yakin ingin menghapus akun ini? Tindakan ini tidak dapat dibatalkan.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(), 
          child: const Text('Batal'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); 
            _confirmDeleteAccount(context);
          },
          child: const Text('Ya, Hapus Akun'),
        ),
      ],
    ),
  );
}


void _confirmDeleteAccount(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Konfirmasi Penghapusan Akun'),
      content: const Text('Apakah Anda benar-benar yakin ingin menghapus akun ini? Akun tidak dapat dipulihkan setelah dihapus.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(), 
          child: const Text('Batal'),
        ),
        TextButton(
          onPressed: () async {
            Navigator.of(context).pop(); 
            await _deleteAccount(context);
          },
          child: const Text('Ya, Hapus Akun'),
        ),
      ],
    ),
  );
}

Future<void> _deleteAccount(BuildContext context) async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {

      await user.delete(); 
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()), 
      );
    }
  } catch (e) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Kesalahan'),
        content: Text('Terjadi kesalahan: ${e.toString()}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PROFIL"),
        foregroundColor: Colors.white,
        centerTitle: true,
        backgroundColor: const Color(0xFF173156),
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
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text(
            email,
            style: TextStyle(color: Colors.grey[600]),
          ),
          const SizedBox(height: 10),
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
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              minimumSize: const Size(130, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text("Edit Profil", style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                ProfileOptionTile(
                  icon: Icons.lock,
                  text: "Ubah Password",
                  backgroundColor: kSecondaryColor,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const change_pass_screen(),
                      ),
                    );
                  },
                ),
                const ProfileOptionTile(
                  icon: Icons.emoji_emotions,
                  text: "MRT-points",
                  backgroundColor: kSecondaryColor,
                ),
                const ProfileOptionTile(
                  icon: Icons.favorite,
                  text: "Favorit",
                  backgroundColor: kSecondaryColor,
                ),
                ProfileOptionTile(
                  icon: Icons.lock,
                  text: "History",
                  backgroundColor: kSecondaryColor,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TicketHistoryScreen(),
                      ),
                    );
                  },
                ),
                ProfileOptionTile(
                  icon: Icons.logout,
                  text: "Logout",
                  textColor: Colors.black,
                  backgroundColor: tertiaryColor,
                  onTap: _showLogoutConfirmation,
                ),
                ProfileOptionTile(
                  icon: Icons.delete_forever,
                  text: "Hapus Akun",
                  textColor: Colors.black,
                  backgroundColor: tertiaryColor,
                  onTap: () => _showDeleteAccountConfirmation(context), 
                ),

              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: const [
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
            // case 2:
            //   Navigator.push(
            //     context,
            //     MaterialPageRoute(builder: (context) => const TicketHistoryScreen()),
            //   );
            //   break;
            case 3:
              break;
          }
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF173156),
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

  const ProfileOptionTile(
      {super.key, required this.icon,
      required this.text,
      this.onTap,
      this.iconColor = Colors.white,
      this.backgroundColor = kSecondaryColor,
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
