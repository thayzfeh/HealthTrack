import 'package:flutter/material.dart';
import 'package:login_tcc/components/buttons.dart';
import 'package:login_tcc/components/colors.dart';
import 'package:login_tcc/components/connections_containers.dart';
import 'package:login_tcc/components/home_patterns.dart';

class ConnectionPage extends StatefulWidget {
  const ConnectionPage({super.key});

  @override
  State<ConnectionPage> createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  int currentSelectedIndex = 0;

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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PrimaryButton(texto: "Conexões", nav: _onPressedNav),
              const SizedBox(
                height: 20,
              ),
              const ConnectionContainer(
                image: 'images/batman.png',
                name: 'Batman',
              ),
              const SizedBox(
                height: 15,
              ),
              const ConnectionContainer(
                image: 'images/obiwan.png',
                name: 'Obiwan',
              ),
              const SizedBox(
                height: 15,
              ),
              const ConnectionContainer(
                image: 'images/jones.png',
                name: 'Jones',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onPressedNav() {
    Navigator.of(context).pushReplacementNamed('/home');
  }
}
