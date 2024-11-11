import 'package:flutter/material.dart';

class change_pass_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("UBAH PASSWORD"),
        foregroundColor: Colors.white,
        centerTitle: true,
        backgroundColor: Color(0xFF173156),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: "Password"),
            ),
            const SizedBox(height: 20),
            TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: "Password Confirm"),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                
              },
              child: Text("Save", style: TextStyle(color: Colors.white, fontSize: 16),),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: Size(150, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
