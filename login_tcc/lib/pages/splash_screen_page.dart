import 'package:login_tcc/components/colors.dart';
import 'package:login_tcc/pages/home_page.dart';
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
      return Future.value(const HomePage());
    }
    return Future.value(const LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      // Stack para que a SplashScreen fique por baixo do loading (checar v2 para entender)
      child: Stack(alignment: Alignment.bottomCenter, children: [
        SizedBox(
            child: EasySplashScreen(
          logo: Image.asset(
            'images/logo_tcc.png',
            height: 100,
          ),
          backgroundColor: ColorStyle.background,
          showLoader: false,
          futureNavigator: futureCall(),
        )),
        Container(
          height:
              MediaQuery.of(context).size.height * 0.3, // 30% do total de tela
          color: ColorStyle.background,
          // Pontinhos
          child: const SpinKitThreeBounce(
            color: ColorStyle.white,
            size: 45.0,
            duration: Duration(seconds: 1),
          ),
        )
      ]),
    ));
  }
}
