import 'package:flutter/material.dart';
import 'services/api_service.dart';
import 'models/pelanggan.dart';
import 'map_page.dart'; // Import halaman map

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  late Future<List<Pelanggan>> futurePelanggan;
  final ApiService apiService = ApiService('http://172.16.95.10/roti/get_pelanggan.php'); // Ganti dengan URL API Anda

  @override
  void initState() {
    super.initState();
    futurePelanggan = apiService.getPelanggan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Pembeli'),
      ),
      body: FutureBuilder<List<Pelanggan>>(
        future: futurePelanggan,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Tidak ada data'));
          } else {
            List<Pelanggan> pelangganList = snapshot.data!;
            return ListView.builder(
              itemCount: pelangganList.length,
              itemBuilder: (context, index) {
                final pelanggan = pelangganList[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16.0),
                    title: Text('${pelanggan.nama} (${pelanggan.email})'),
                    subtitle: Text(
                      'No Telepon: ${pelanggan.noTelepon}\nAlamat: ${pelanggan.alamat}\nRoti ID: ${pelanggan.rotiId}\nWaktu Pembelian: ${pelanggan.waktuPembelian}',
                    ),
                    isThreeLine: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MapPage(pelanggan: pelanggan),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
