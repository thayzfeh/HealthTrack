import 'package:login_tcc/pages/login_page.dart';
import 'package:login_tcc/services/prefs_service.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  Future<Widget> futureCall() async {
    bool isAuth = await PrefsService.isAuth();
    await Future.delayed(const Duration(seconds: 5));
    if (isAuth) {
      return Future.value(const LoginPage());
    }
    return Future.value(const LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(children: [
        Container(
            height: MediaQuery.of(context).size.height * 0.8, // 80% da tela
            width: MediaQuery.of(context).size.width,
            child: EasySplashScreen(
              logo: Image.asset(
                'images/logo_tcc.png',
                height: 100,
              ),
              backgroundColor: const Color(0xff001975),
              showLoader: false,
              // loaderColor: Colors.white,
              /*loadingText: const Text("Loading...",
              style: TextStyle(
                  color: Colors.white, fontSize: 20, fontFamily: "Arial")),
                  */
              futureNavigator: futureCall(),
            )),
        Container(
          height: MediaQuery.of(context).size.height * 0.2, // 20% da tela
          color: const Color(0xff001975),
          child: const SpinKitThreeBounce(
            // Pontinhos
            color: Colors.white, // Cor dos pontinhos
            size: 50.0,
            duration: Duration(seconds: 1), // Tamanho dos pontinhos
          ),
        )
      ]),
    ));
  }
}
