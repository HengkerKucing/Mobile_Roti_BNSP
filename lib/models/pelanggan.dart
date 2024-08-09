class Pelanggan {
  final int id;
  final String nama;
  final String email;
  final String noTelepon;
  final String alamat;
  final int rotiId;
  final String waktuPembelian;
  final double latitude; // Menggunakan nama kolom yang sesuai
  final double longitude; // Menggunakan nama kolom yang sesuai

  Pelanggan({
    required this.id,
    required this.nama,
    required this.email,
    required this.noTelepon,
    required this.alamat,
    required this.rotiId,
    required this.waktuPembelian,
    required this.latitude,
    required this.longitude,
  });

  factory Pelanggan.fromJson(Map<String, dynamic> json) {
    return Pelanggan(
      id: int.parse(json['id'].toString()), 
      nama: json['nama'],
      email: json['email'],
      noTelepon: json['no_telepon'],
      alamat: json['alamat'],
      rotiId: int.parse(json['roti_id'].toString()), 
      waktuPembelian: json['waktu_pembelian'],
      latitude: json['gps_lat'] != null ? double.parse(json['gps_lat'].toString()) : 0.0,
      longitude: json['gps_lng'] != null ? double.parse(json['gps_lng'].toString()) : 0.0,
    );
  }
}
