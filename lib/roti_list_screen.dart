import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'detail_screen.dart';

class RotiListScreen extends StatelessWidget {
  Future<List<dynamic>> fetchRoti() async {
    final response = await http.get(Uri.parse('http://172.16.95.10/roti/get_roti.php'));

    if (response.statusCode == 200) {
      try {
        return json.decode(response.body);
      } catch (e) {
        throw Exception('Error parsing JSON: $e');
      }
    } else {
      throw Exception('Failed to load roti');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Daftar Roti")),
      body: FutureBuilder<List<dynamic>>(
        future: fetchRoti(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Tidak ada data roti"));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Image.network(snapshot.data![index]['gambar_url']),
                title: Text(snapshot.data![index]['nama_roti']),
                subtitle: Text(snapshot.data![index]['deskripsi']),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(roti: snapshot.data![index]),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
