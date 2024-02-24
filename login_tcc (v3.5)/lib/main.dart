import 'package:flutter/material.dart';
import 'package:login_tcc/pages/cadastro_page.dart';
import 'package:login_tcc/pages/splash_screen_page.dart';
import 'package:login_tcc/pages/maps_page.dart';
import 'package:login_tcc/pages/login_page.dart';

void main() => runApp(const TccHome());

class TccHome extends StatelessWidget {
  const TccHome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreenPage(),
          '/login': (context) => const LoginPage(),
          '/cadastro': (context) => const CadastroPage(),
          '/maps': (context) => const MapWidget()
        });
  }
}
