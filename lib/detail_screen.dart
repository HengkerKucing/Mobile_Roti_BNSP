import 'package:flutter/material.dart';
import 'beli_screen.dart';

class DetailScreen extends StatelessWidget {
  final Map<String, dynamic> roti;

  DetailScreen({required this.roti});

  @override
  Widget build(BuildContext context) {
    // Validasi data dari 'roti' untuk menghindari error
    final String gambarUrl = roti['gambar_url'] ?? '';
    final String namaRoti = roti['nama_roti'] ?? 'Nama Roti';
    final String deskripsi = roti['deskripsi'] ?? 'Deskripsi tidak tersedia';
    final String harga = roti['harga'] ?? 'Harga tidak tersedia';
    final int rotiId = roti['id'] != null ? int.tryParse(roti['id'].toString()) ?? 0 : 0;

    return Scaffold(
      appBar: AppBar(title: Text(namaRoti)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              gambarUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200.0,
              errorBuilder: (context, error, stackTrace) => Center(child: Text('Gambar tidak tersedia')),
            ),
            SizedBox(height: 16.0),
            Text(
              namaRoti,
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(
              deskripsi,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              "Harga: Rp${harga}",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BeliScreen(rotiId: rotiId),
                  ),
                );
              },
              child: Text("Beli"),
            ),
          ],
        ),
      ),
    );
  }
}
