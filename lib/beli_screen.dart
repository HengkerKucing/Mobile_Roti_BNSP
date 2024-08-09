import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class BeliScreen extends StatefulWidget {
  final int rotiId;

  BeliScreen({required this.rotiId});

  @override
  _BeliScreenState createState() => _BeliScreenState();
}

class _BeliScreenState extends State<BeliScreen> {
  final _formKey = GlobalKey<FormState>();
  String? nama, email, noTelepon, alamat;
  double? gpsLat, gpsLng;

  Future<void> getGPSLocation() async {
    try {
      // Memeriksa izin lokasi terlebih dahulu
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Layanan lokasi tidak aktif")));
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Izin lokasi ditolak")));
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Izin lokasi tidak dapat dipulihkan")));
        return;
      }

      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {
        gpsLat = position.latitude;
        gpsLng = position.longitude;
      });
    } catch (e) {
      print("Error getting GPS location: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error getting GPS location: $e")));
    }
  }

  Future<void> submitForm() async {
    await getGPSLocation();

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        final response = await http.post(
          Uri.parse('http://172.16.95.10/roti/beli_roti.php'),
          body: {
            "nama": nama!,
            "email": email!,
            "no_telepon": noTelepon!,
            "alamat": alamat!,
            "gps_lat": gpsLat.toString(),
            "gps_lng": gpsLng.toString(),
            "roti_id": widget.rotiId.toString(),
          },
        );

        if (response.statusCode == 200) {
          final result = response.body.trim();
          print("Response from server: $result");
          if (result.contains("Pembelian berhasil")) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Pembelian berhasil")));
            Navigator.pop(context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Pembelian gagal: $result")));
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Pembelian gagal dengan status code: ${response.statusCode}")));
        }
      } catch (e) {
        print("Error submitting form: $e");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error submitting form")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Beli Roti")),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nama'),
                onSaved: (value) => nama = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Harap masukkan nama Anda';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                onSaved: (value) => email = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Harap masukkan email Anda';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'No Telepon'),
                onSaved: (value) => noTelepon = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Harap masukkan nomor telepon Anda';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Alamat'),
                onSaved: (value) => alamat = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Harap masukkan alamat Anda';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: submitForm,
                child: Text("Beli"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
