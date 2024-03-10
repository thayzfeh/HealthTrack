import 'package:flutter/material.dart';
import 'package:login_tcc/components/colors.dart';
import 'package:login_tcc/components/home_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentSelectedIndex = 1;

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
          onDestinationSelected: (int index) {
            setState(() {
              currentSelectedIndex = index;
            });
          },
          destinations: <Widget>[
            NavigationDestination(
              icon: Icon(Icons.share, size: MediaQuery.of(context).size.width * 0.1),
              label: 'Conexões',
            ),
            NavigationDestination(
              icon: Icon(Icons.desktop_windows_outlined, size: MediaQuery.of(context).size.width * 0.1),
              label: 'Monitoramento',
            ),
            NavigationDestination(
              icon: Icon(Icons.person, size: MediaQuery.of(context).size.width * 0.1),
              label: "Perfil",
            ),
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
                const RetroButton(path: '/login',),
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
                HomeContainer(
                  icon: Icons.tire_repair,
                  color: Colors.yellow.shade700,
                  title: '120',
                  subtitle: 'mmHg',
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                // Glicemia
                const HomeContainer(
                    icon: Icons.water_drop,
                    color: Colors.red,
                    title: "120",
                    subtitle: "mg/dl")
              ],
            ),
          ),
        ));
  }
}
