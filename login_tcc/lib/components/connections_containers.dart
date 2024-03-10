import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_tcc/components/colors.dart';

class ConnectionContainer extends StatefulWidget {
  const ConnectionContainer({
    super.key,
    required String image,
    required String name,
  })  : _image = image,
        _name = name;

  final String _image;
  final String _name;

  @override
  State<ConnectionContainer> createState() => _ConnectionContainerState();
}

class _ConnectionContainerState extends State<ConnectionContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24), color: ColorStyle.white),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.03, 0, 0, 0),
                child: Image(
                  image: AssetImage(widget._image),
                  filterQuality: FilterQuality.high,
                  width: MediaQuery.of(context).size.height * 0.13,
                ),
              ),
              Row(
                children: [
                  Text(
                    widget._name,
                    style: GoogleFonts.arimo(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.height * 0.025),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(6, 0, 0, 0),
                    child: Image(
                      image: const AssetImage('images/premium.png'),
                      width: MediaQuery.of(context).size.height * 0.04,
                    ),
                  )
                ],
              )
            ],
          ),
          const ConnectionColumn(
            icon: Icons.heart_broken,
            text: '120',
            color: ColorStyle.green,
          ),
          const ConnectionColumn(
            icon: Icons.tire_repair,
            text: '120',
            color: ColorStyle.yellow,
          ),
          const ConnectionColumn(
            icon: Icons.water_drop,
            text: '120',
            color: ColorStyle.red,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.location_on,
                    size: MediaQuery.of(context).size.height * 0.04),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/maps');
                },
                color: ColorStyle.red,
              )
            ],
          )
        ],
      ),
    );
  }
}

class ConnectionColumn extends StatefulWidget {
  const ConnectionColumn({
    super.key,
    required IconData icon,
    required String text,
    required Color color,
  })  : _icon = icon,
        _text = text,
        _color = color;

  final IconData _icon;
  final String _text;
  final Color _color;

  @override
  State<ConnectionColumn> createState() => _ConnectionColumnState();
}

class _ConnectionColumnState extends State<ConnectionColumn> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            widget._icon,
            color: widget._color,
            size: MediaQuery.of(context).size.height * 0.05,
          ),
          Text(
            widget._text,
            style: GoogleFonts.arimo(
                color: widget._color,
                fontSize: MediaQuery.of(context).size.height * 0.022),
          ),
        ],
      ),
    );
  }
}
