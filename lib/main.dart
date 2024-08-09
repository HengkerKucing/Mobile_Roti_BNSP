import 'package:flutter/material.dart';
import 'home_screen.dart'; // Import layar baru
 // Import layar membeli roti

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Roti',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(), // Ganti dengan HomeScreen
    );
  }
}
