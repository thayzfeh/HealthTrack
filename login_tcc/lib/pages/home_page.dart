import 'package:flutter/material.dart';

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
        backgroundColor: const Color(0xff001975),
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height * 0.005,
          shadowColor: const Color(0xff001975),
          backgroundColor: const Color(0xff001975),
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: currentSelectedIndex,
          indicatorShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          backgroundColor: Colors.white,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          onDestinationSelected: (int index) {
            setState(() {
              currentSelectedIndex = index;
            });
          },
          destinations: const <Widget>[
            NavigationDestination(
              icon: Icon(Icons.share, size: 40),
              label: 'Conexões',
            ),
            NavigationDestination(
              icon: Icon(Icons.desktop_windows_outlined, size: 40),
              label: 'Monitoramento',
            ),
            NavigationDestination(
              icon: Icon(Icons.person, size: 40),
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
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed("/login");
                  },
                  style: ElevatedButton.styleFrom(
                      alignment: Alignment.center,
                      backgroundColor: const Color(0xff001975),
                      shadowColor: Colors.transparent,
                      padding: const EdgeInsets.fromLTRB(0, 0, 260, 25)),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 35,
                    color: Colors.white,
                  ),
                ),
                // Batimentos
                Container(
                  height: MediaQuery.of(context).size.height * 0.22,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.white),
                  child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0.0, 7.0, 0.0, 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                  padding: EdgeInsets.fromLTRB(5, 10, 0, 0),
                                  child: Icon(Icons.heart_broken,
                                      color: Colors.green, size: 100)),
                              Column(
                                children: [
                                  Text(
                                    "120",
                                    style: TextStyle(
                                      fontSize: 50,
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "bpm",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Expandir",
                              ),
                              Icon(Icons.arrow_forward_ios),
                            ],
                          ),
                        ),
                      ]),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                // Pressão
                Container(
                  height: MediaQuery.of(context).size.height * 0.22,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.white),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 7.0, 0.0, 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Icon(
                                  Icons.tire_repair,
                                  color: Colors.yellow.shade700,
                                  size: 100,
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    "120",
                                    style: TextStyle(
                                      fontSize: 50,
                                      color: Colors.yellow.shade700,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Text(
                                    "mmHg",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Expandir",
                              ),
                              Icon(Icons.arrow_forward_ios),
                            ],
                          ),
                        ),
                      ]),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                // Glicemia
                Container(
                  height: MediaQuery.of(context).size.height * 0.22,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: Colors.white),
                  child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Icon(
                                  Icons.water_drop,
                                  color: Colors.red,
                                  size: 100,
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    "120",
                                    style: TextStyle(
                                      fontSize: 50,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "mmHg",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Expandir",
                              ),
                              Icon(Icons.arrow_forward_ios),
                            ],
                          ),
                        ),
                      ]),
                ),
              ],
            ),
          ),
        ));
  }
}