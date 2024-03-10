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
              Color(0xff5de0e6),
              Color(0xff004aad),
            ])),
        child: ElevatedButton(
            onPressed: widget._nav,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              textStyle: TextStyle(
                  color: ColorStyle.white,
                  fontSize: MediaQuery.of(context).size.height * 0.045),
              padding: const EdgeInsets.all(25),
            ),
            child: Text(widget._texto,
                style: GoogleFonts.arimo(
                    color: ColorStyle.white, fontWeight: FontWeight.bold))));
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
