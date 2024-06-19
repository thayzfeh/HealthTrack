import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_tcc/components/colors.dart';

class PrimaryButton extends StatefulWidget {
  const PrimaryButton({
    super.key,
    required String texto,
    required void Function() nav,
  })  : _nav = nav,
        _texto = texto;

  final void Function() _nav;
  final String _texto;

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: const LinearGradient(colors: [
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(255, 226, 226, 226),
            ])),
        child: ElevatedButton(
            onPressed: widget._nav,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              textStyle: TextStyle(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontSize: MediaQuery.of(context).size.height * 0.045),
              padding: const EdgeInsets.all(25),
            ),
            child: Text(widget._texto,
                style: GoogleFonts.arimo(
                    color: const Color.fromARGB(255, 0, 0, 0), fontWeight: FontWeight.bold))));
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
