import 'dart:convert';
import 'package:d_info/d_info.dart';
import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sertifikasi3/admin_screen.dart';
// import 'package:sertifikasi3/roti_list_screen.dart';
// import 'package:junior_mobile/homepage.dart';
// import 'package:junior_mobile/registerpage.dart';

class LoginPage extends StatelessWidget {
    LoginPage({super.key});
  final controllerUsername = TextEditingController();
  final controllerPassword = TextEditingController();

  login(BuildContext context) async{
    String url = 'http://172.16.95.10/sertifikasi_jmp/user/login.php';
    var response = await http.post(Uri.parse(url), body: {
      'username' : controllerUsername.text,
      'password' : controllerPassword.text
    });
    Map responseBody = jsonDecode(response.body);
    if(responseBody['success']) {
      DInfo.toastSuccess('Login Success');
      Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdminScreen(),
      ),
      );
    }else{
      DInfo.toastError('Login Failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DView.textTitle('Login Page', color: Colors.black),
          DView.height(),
          DInput(controller: controllerUsername, hint: 'username'),
          DView.height(),
          DInput(controller: controllerPassword, hint: 'password'),
          DView.height(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => login(context), 
            child: Text('Login')),
          ),
          DView.height(),
          // SizedBox(
          //   width: double.infinity,
          //   child: OutlinedButton(onPressed: () {
          //     Navigator.push(context, MaterialPageRoute(builder: (context) => Registerpage()));
          //   }, 
          //   child: Text('Register')),
          // )

        ],
      ),
    ));
  }
}