import 'package:flutter/material.dart';
import 'package:login_tcc/components/colors.dart';

class HomeContainer extends StatefulWidget {
  const HomeContainer({
    super.key,
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
  })  : _icon = icon,
        _color = color,
        _title = title,
        _subtitle = subtitle;

  final IconData _icon;
  final Color _color;
  final String _title;
  final String _subtitle;

  @override
  State<HomeContainer> createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.23,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24), color: ColorStyle.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.03, 0, 0, 0),
                child: Icon(
                  widget._icon,
                  color: widget._color,
                  size: MediaQuery.of(context).size.height * 0.16,
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget._title,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.06,
                  color: widget._color,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget._subtitle,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * 0.030,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed('/bpm');
                      },
                      style: ElevatedButton.styleFrom(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.fromLTRB(MediaQuery.of(context).size.width * 0.1, 0, 0, 0)),
                      child: const Text("Expandir",
                          style: TextStyle(color: Colors.black))),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed('/bpm');
                      },
                      style: ElevatedButton.styleFrom(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.fromLTRB(0, 0, MediaQuery.of(context).size.width * 0.02, 0),
                      ),
                      icon: const Icon(Icons.arrow_forward_ios)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RetroButton extends StatefulWidget {
  const RetroButton({
    super.key,
    required String path,
  }) : _path = path;

  final String _path;

  @override
  State<RetroButton> createState() => _RetroButtonState();
}

class _RetroButtonState extends State<RetroButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(widget._path);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 35,
            color: ColorStyle.white,
          ),
        ),
      ],
    );
  }
}
