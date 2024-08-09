import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'models/pelanggan.dart';

class MapPage extends StatelessWidget {
  final Pelanggan pelanggan;

  const MapPage({Key? key, required this.pelanggan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LatLng lokasi = LatLng(pelanggan.latitude, pelanggan.longitude);

    final Marker marker = Marker(
      markerId: MarkerId('marker_${pelanggan.id}'),
      position: lokasi,
      infoWindow: InfoWindow(
        title: pelanggan.nama,
        snippet: pelanggan.alamat,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Lokasi Pembeli'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: lokasi,
          zoom: 15,
        ),
        markers: {marker},
      ),
    );
  }
}
