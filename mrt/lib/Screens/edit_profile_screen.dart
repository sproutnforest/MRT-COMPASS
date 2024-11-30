import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mrt/constant.dart';
import 'package:path_provider/path_provider.dart';

class EditProfileScreen extends StatefulWidget {
  final String currentName;
  final String currentEmail;
  final String? currentImagePath;

  const EditProfileScreen(
      {super.key,
      required this.currentName,
      required this.currentEmail,
      this.currentImagePath});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  File? _profileImage;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.currentName);
    emailController = TextEditingController(text: widget.currentEmail);
    if (widget.currentImagePath != null) {
      _profileImage =
          File(widget.currentImagePath!);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("EDIT PROFIL"),
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundImage: _profileImage != null
                      ? FileImage(_profileImage!)
                      : widget.currentImagePath != null
                          ? FileImage(File(widget
                              .currentImagePath!))
                          : const AssetImage('assets/blank-profile.png')
                              as ImageProvider,
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: const CircleAvatar(
                      radius: 18,
                      backgroundColor: kSecondaryColor,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Nama"),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
              enabled: false,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {
                  'name': nameController.text,
                  'email': emailController.text,
                  'profileImage': _profileImage?.path,
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: const Size(150, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: const Text(
                "Save",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
