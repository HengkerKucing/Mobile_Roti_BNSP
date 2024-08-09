import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pelanggan.dart';

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<List<Pelanggan>> getPelanggan() async {
    final response = await http.get(Uri.parse('$baseUrl/get_pelanggan.php'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => Pelanggan.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
