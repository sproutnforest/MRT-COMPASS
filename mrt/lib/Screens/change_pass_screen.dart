import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mrt/Screens/profile_screen.dart';

class ChangePassScreen extends StatefulWidget {
  const ChangePassScreen({super.key});

  @override
  _ChangePassScreenState createState() => _ChangePassScreenState();
}

class _ChangePassScreenState extends State<ChangePassScreen> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Show error dialog
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

  // Show success dialog
  // void _showSuccessDialog(String message) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: const Text('Success'),
  //       content: Text(message),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.of(context).pop(),
  //           child: const Text('OK'),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Function to check password validity
  bool _isPasswordValid(String password) {
    // Regular expression to check password strength
    RegExp regExp = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$',
    );
    return regExp.hasMatch(password);
  }

  void _changePassword() async {
    final User? user = _auth.currentUser;

    if (user == null) {
      _showErrorDialog('No user is currently signed in.');
      return;
    }

    final String oldPassword = _oldPasswordController.text;
    final String newPassword = _newPasswordController.text;
    final String confirmPassword = _confirmPasswordController.text;

    // Validate if the new password meets the criteria
    if (!_isPasswordValid(newPassword)) {
      _showErrorDialog(
          'Password must contain at least 1 lowercase letter, 1 uppercase letter, 1 special character, and 1 number.');
      return;
    }

    if (newPassword != confirmPassword) {
      _showErrorDialog('New passwords do not match.');
      return;
    }

    try {
      // Reauthenticate the user with their old password
      final AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: oldPassword,
      );

      await user.reauthenticateWithCredential(credential);

      // Now update the password
      await user.updatePassword(newPassword);
      await user.reload();
      final User? updatedUser = _auth.currentUser;

      // Update user information in Firestore if needed (e.g., name, email, etc.)
      final email = updatedUser?.email;
      if (email != null) {
        final querySnapshot = await FirebaseFirestore.instance
            .collection('Users')
            .where('email', isEqualTo: email)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          final doc = querySnapshot.docs.first;
          await doc.reference.update({
            'password':
                newPassword, // Not recommended to store password, but for the sake of this example
          });
        }
      }

      // Show success dialog
      _showSuccessDialog('Password successfully updated.');
    } catch (e) {
      _showErrorDialog('Failed to update password: ${e.toString()}');
    }
  }

// Success dialog with navigation to profile page
  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              // Close the dialog
              Navigator.of(context).pop();
              // Navigate to profile page
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ProfileScreen()), // Ganti ProfileScreen() dengan halaman profil yang sesuai
              );
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("UBAH PASSWORD"),
        foregroundColor: Colors.white,
        centerTitle: true,
        backgroundColor: const Color(0xFF173156),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Old password field
            TextField(
              controller: _oldPasswordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password Lama"),
            ),
            const SizedBox(height: 20),

            // New password field
            TextField(
              controller: _newPasswordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password Baru"),
            ),
            const SizedBox(height: 20),

            // Confirm new password field
            TextField(
              controller: _confirmPasswordController,
              obscureText: true,
              decoration:
                  const InputDecoration(labelText: "Konfirmasi Password Baru"),
            ),
            const SizedBox(height: 40),

            // Save button
            ElevatedButton(
              onPressed: _changePassword,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: const Size(150, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: const Text(
                "Simpan",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
