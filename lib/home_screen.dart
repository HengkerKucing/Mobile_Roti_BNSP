import 'package:flutter/material.dart';
import 'package:sertifikasi3/login.dart';
import 'roti_list_screen.dart'; // Pastikan file ini sudah ada

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selamat Datang'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Navigasi ke layar login admin
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text('Login sebagai Admin'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigasi ke layar membeli roti
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RotiListScreen()),
                );
              },
              child: Text('Membeli Roti'),
            ),
          ],
        ),
      ),
    );
  }
}
