import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_tcc/models/user.dart';
import 'package:login_tcc/services/prefs_service.dart';

class RegisterController {
  final User user;

  RegisterController({required this.user});

  Future<bool> isValid(context) async {
    String url = "http://htwebapi-production.up.railway.app/auth/register";
    try {
      var response = await http.post(Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            'email': user.email,
            'password': user.password,
            'username': user.username,
            'birth': user.birth,
            'phone': user.phone,
            'cpf': user.cpf
          }));
      if (response.statusCode == 301 || response.statusCode == 302) {
        String redirectUrl = response.headers['location']!;
        response = await http.post(Uri.parse(redirectUrl),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'email': user.email,
              'password': user.password,
              'username': user.username,
              'birth': user.birth,
              'phone': user.phone,
              'cpf': user.cpf
            }));
      }
      var resposta = jsonDecode(response.body);
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(resposta['msg']),
          duration: const Duration(seconds: 5),
        ));
        await Future.delayed(const Duration(seconds: 5));
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
