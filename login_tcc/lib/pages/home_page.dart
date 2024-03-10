import 'package:flutter/material.dart';
import 'package:login_tcc/components/buttons.dart';
import 'package:login_tcc/components/colors.dart';
import 'package:login_tcc/components/home_patterns.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentSelectedIndex = 1;

  final rotas = <int, String>{0: '/connection', 1: '/home'};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorStyle.background,
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height * 0.005,
          shadowColor: ColorStyle.background,
          backgroundColor: ColorStyle.background,
        ),
        bottomNavigationBar: NavigationBar(
          height: MediaQuery.of(context).size.height * 0.11,
          selectedIndex: currentSelectedIndex,
          indicatorShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: ColorStyle.white,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          onDestinationSelected: (index) {
            Navigator.pushReplacementNamed(context, rotas[index]!);
          },
          destinations: const <Widget>[
            HomeNavigationDestination(icon: Icons.share, label: 'Conexões'),
            HomeNavigationDestination(
                icon: Icons.desktop_windows_outlined, label: "Monitoramento"),
            HomeNavigationDestination(icon: Icons.person, label: "Perfil"),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const RetroButton(
                  path: '/login',
                ),
                // Batimentos
                const HomeContainer(
                    icon: Icons.heart_broken,
                    color: ColorStyle.green,
                    title: "120",
                    subtitle: "bpm"),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                // Pressão
                const HomeContainer(
                  icon: Icons.tire_repair,
                  color: ColorStyle.yellow,
                  title: '120',
                  subtitle: 'mmHg',
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                // Glicemia
                const HomeContainer(
                    icon: Icons.water_drop,
                    color: ColorStyle.red,
                    title: "120",
                    subtitle: "mg/dl")
              ],
            ),
          ),
        ));
  }
}
