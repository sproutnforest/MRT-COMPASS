import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:cloud_firestore/cloud_firestore.dart'; // Import yang benar untuk Firestore

class EditProfileScreen extends StatefulWidget {
  final String currentName;
  final String currentEmail;

  const EditProfileScreen(
      {super.key, required this.currentName, required this.currentEmail});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController nameController;
  String? newProfileImagePath; // Path gambar lokal

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.currentName);
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  // Fungsi untuk memilih gambar dan menyimpannya secara lokal
  Future<String?> _pickAndSaveImage() async {
  try {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage == null) return null;

    // Mendapatkan direktori aplikasi untuk menyimpan gambar
    final directory = await getApplicationDocumentsDirectory();
    String fileName = path.basename(pickedImage.path);
    File localImage = File('${directory.path}/$fileName');

    // Salin file gambar ke direktori aplikasi
    await pickedImage.saveTo(localImage.path);

    return localImage.path; // Mengembalikan path gambar yang disimpan
  } catch (e) {
    print("Error saving image locally: $e");
    return null;
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("EDIT PROFIL"),
        backgroundColor: Colors.blue,
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
                  backgroundImage: newProfileImagePath != null
                      ? FileImage(File(newProfileImagePath!))
                      : const AssetImage('assets/profile_image.png')
                          as ImageProvider,
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: GestureDetector(
                    onTap: () async {
                      String? imagePath = await _pickAndSaveImage();

                      if (imagePath != null) {
                        setState(() {
                          newProfileImagePath = imagePath;
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text("Foto profil berhasil diperbarui.")),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Gagal memperbarui foto profil.")),
                        );
                      }
                    },
                    child: const CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.grey,
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
            const SizedBox(height: 40),
            ElevatedButton(
  onPressed: () async {
    String updatedName = nameController.text;

    try {
      // Update nama dan gambar profil di Firestore
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(widget.currentEmail)
          .update({
        'name': updatedName,
        if (newProfileImagePath != null)
          'profil': newProfileImagePath, // Simpan path gambar di Firestore
      });

      // Kembalikan data yang sudah diperbarui
      Navigator.pop(context, {
        'name': updatedName,
        'profil': newProfileImagePath,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profil berhasil diperbarui.")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Gagal memperbarui profil.")),
      );
    }
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
)

          ],
        ),
      ),
    );
  }
}
