import 'package:flutter/material.dart';
import 'package:mrt/Screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mrt/Screens/ticket.dart';
import 'package:mrt/Screens/ticket_screen_history.dart';
import 'change_pass_screen.dart';
import 'edit_profile_screen.dart';
import 'login_screen.dart';
import 'package:mrt/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Screens/customer_service_screen.dart';
import 'about_us_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  User? user;
  String name = "Loading...";
  String email = "Loading...";
  int _selectedIndex = 2;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() {
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        name = user!.displayName ?? "No Name";
        email = user!.email ?? "No Email";
      });
    }
  }

  void _showCustomerService(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CustomerServiceScreen(),
      ),
    );
  }

  void updateProfile(String newName, String newEmail) async {
    try {
      if (user != null) {
        await user!.updateDisplayName(newName);

        final querySnapshot = await FirebaseFirestore.instance
            .collection('Users')
            .where('email', isEqualTo: user!.email)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          final doc = querySnapshot.docs.first;
          await doc.reference.update({
            'name': newName,
          });

          await user!.reload();
          user = FirebaseAuth.instance.currentUser;

          setState(() {
            name = user!.displayName ?? "No Name";
            email = user!.email ?? "No Email";
          });

          _showInfoDialog("Profil berhasil diperbarui.");
        } else {
          _showErrorDialog(
              "Pengguna dengan email ${user!.email} tidak ditemukan di Firestore.");
        }
      }
    } catch (e) {
      _showErrorDialog('Error updating profile: ${e.toString()}');
    }
  }

  void _showInfoDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Info'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Akun'),
        content: const Text(
            'Apakah Anda yakin ingin menghapus akun ini? Tindakan ini tidak bisa dibatalkan.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _deleteAccount();
            },
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }

  Future<void> deleteUserDataByEmail(String email) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('Users')
          .where('email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isEmpty) {
        throw Exception('Data pengguna dengan email $email tidak ditemukan.');
      }

      for (var doc in querySnapshot.docs) {
        await doc.reference.delete();
        debugPrint('Data pengguna dengan ID dokumen ${doc.id} berhasil dihapus.');
      }
    } catch (e) {
     debugPrint('Gagal menghapus data pengguna: $e');
    }
  }

  void _deleteAccount() async {
    try {
      if (user == null) {
        throw Exception('Tidak ada pengguna yang login.');
      }

      final email = user!.email;

      if (email != null) {
        await deleteUserDataByEmail(email);
      }

      await user!.delete();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Akun berhasil dihapus.')),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menghapus akun: $e')),
        );
      }
    }
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
              FirebaseAuth.instance.signOut();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PROFIL"),
        foregroundColor: Colors.white,
        centerTitle: true,
        backgroundColor: kPrimaryColor,
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
            child: const Text("Edit Profil",
                style: TextStyle(color: Colors.white)),
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
                        builder: (context) => const ChangePassScreen(),
                      ),
                    );
                  },
                ),
                const ProfileOptionTile(
                  icon: Icons.emoji_emotions,
                  text: "MRT-points",
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
                  icon: Icons.headset_mic,
                  text: "Customer Service",
                  textColor: Colors.black,
                  backgroundColor: kSecondaryColor,
                  onTap: () => _showCustomerService(context),
                ),
                ProfileOptionTile(
                  icon: Icons.info_outline,
                  text: "About Us",
                  textColor: Colors.black,
                  backgroundColor: kSecondaryColor,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AboutUsScreen()),
                  ),
                ),
                ProfileOptionTile(
                  icon: Icons.logout,
                  text: "Logout",
                  textColor: tertiaryColor,
                  backgroundColor: tertiaryColor,
                  onTap: _showLogoutConfirmation,
                ),
                ProfileOptionTile(
                  icon: Icons.delete_forever,
                  text: "Hapus Akun",
                  textColor: tertiaryColor,
                  backgroundColor: tertiaryColor,
                  onTap: _showDeleteAccountConfirmation,
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
                MaterialPageRoute(builder: (context) => const TicketScreen()),
              );
              break;
            case 2:
              break;
          }
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        backgroundColor: kPrimaryColor,
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

  const ProfileOptionTile({
    super.key,
    required this.icon,
    required this.text,
    this.onTap,
    this.iconColor = Colors.white,
    this.backgroundColor = kSecondaryColor,
    this.iconSize = 18.0,
    this.textColor = Colors.black,
  });

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
