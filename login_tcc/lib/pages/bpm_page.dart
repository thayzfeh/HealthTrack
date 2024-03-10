import 'package:flutter/material.dart';
import 'package:login_tcc/components/home_container.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_tcc/components/colors.dart';

class BpmPage extends StatefulWidget {
  const BpmPage({super.key});

  @override
  State<BpmPage> createState() => _BpmPageState();
}

class _BpmPageState extends State<BpmPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorStyle.white,
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height * 0.02,
          shadowColor: ColorStyle.white,
          backgroundColor: ColorStyle.white,
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(
              color: ColorStyle.green,
              height: MediaQuery.of(context).size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.02, 0, 0, 0),
                    child: const RetroButton(
                      path: '/home',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, MediaQuery.of(context).size.width * 0.15, 0),
                    child: Text(
                      "Batimentos",
                      style: GoogleFonts.arimo(
                        color: ColorStyle.white,
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.height * 0.05,
                      ),
                    ),
                  ),
                  const Text("")
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, MediaQuery.of(context).size.width * 0.01, MediaQuery.of(context).size.height * 0.07),
                    child: Icon(
                      Icons.heart_broken,
                      color: ColorStyle.green,
                      size: MediaQuery.of(context).size.height * 0.09,
                    ),
                  ),
                  Text(
                    "60",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.1,
                      color: ColorStyle.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
                    child: Text(
                      textAlign: TextAlign.end,
                      "bpm",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * 0.035,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: ColorStyle.white,
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width * 0.9,
              child: SfCartesianChart(
                primaryXAxis: const CategoryAxis(
                  interval: 4,
                  majorGridLines:
                      MajorGridLines(width: 0.3, color: Colors.grey),
                ),
                primaryYAxis: const NumericAxis(
                  interval: 20,
                  majorGridLines:
                      MajorGridLines(width: 0.3, color: Colors.grey),
                ),
                // title: const ChartTitle(text: 'Leituras de Batimentos Cardíacos'),
                series: [
                  LineSeries<BatimentosData, String>(
                    dataSource: <BatimentosData>[
                      BatimentosData('00:00', 65),
                      BatimentosData('01:00', 68),
                      BatimentosData('02:00', 70),
                      BatimentosData('03:00', 72),
                      BatimentosData('04:00', 75),
                      BatimentosData('05:00', 78),
                      BatimentosData('06:00', 80),
                      BatimentosData('07:00', 82),
                      BatimentosData('08:00', 70),
                      BatimentosData('09:00', 75),
                      BatimentosData('10:00', 80),
                      BatimentosData('11:00', 85),
                      BatimentosData('12:00', 88),
                      BatimentosData('13:00', 90),
                      BatimentosData('14:00', 92),
                      BatimentosData('15:00', 88),
                      BatimentosData('16:00', 85),
                      BatimentosData('17:00', 82),
                      BatimentosData('18:00', 80),
                      BatimentosData('19:00', 78),
                      BatimentosData('20:00', 75),
                      BatimentosData('21:00', 72),
                      BatimentosData('22:00', 70),
                      BatimentosData('23:00', 68),
                      // Adicione mais dados conforme necessário
                    ],
                    xValueMapper: (BatimentosData data, _) => data.time,
                    yValueMapper: (BatimentosData data, _) => data.value,
                  ),
                ],
              ),
            ),
          ]),
        ));
  }
}

class BatimentosData {
  final String time;
  final double value;

  BatimentosData(this.time, this.value);
}
