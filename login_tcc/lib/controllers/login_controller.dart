import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:login_tcc/models/user.dart';
import 'package:login_tcc/services/prefs_service.dart';
import 'package:http/http.dart' as http;

class LoginController {
  final User user;

  LoginController({required this.user});

  Future<bool> isValid(context) async {
    String url = "http://htwebapi-production.up.railway.app/auth/login";
    try {
      var response = await http.post(Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'email': user.email,
            'password': user.password,
          }));
      if (response.statusCode == 301 || response.statusCode == 302) {
        String redirectUrl = response.headers['location']!;
        response = await http.post(Uri.parse(redirectUrl),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'email': user.email,
              'password': user.password,
            }));
      }
      var resposta = jsonDecode(response.body);
      if (response.statusCode == 200) {
        PrefsService.save(resposta);
        return true;
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(resposta['msg']),
      ));
      print("bbbbbbbbbb deslogou!!!");
      return false;
    } catch (e) {
      print('erro na requisicao: $e');
      return false;
    }
  }
}
