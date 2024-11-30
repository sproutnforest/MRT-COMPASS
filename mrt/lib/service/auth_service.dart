import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> registerUser(String email, String password, String username) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // Save user data in Firestore
      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'username': username.trim(),
        'email': email.trim(),
        'password': _hashPassword(password),
        'isVerified': false,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception("Error registering user: $e");
    }
  }

  String _hashPassword(String password) {
    return password;
  }
}
