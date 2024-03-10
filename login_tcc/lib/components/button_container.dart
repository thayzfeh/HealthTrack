import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_tcc/components/colors.dart';

class ButtonContainer extends StatefulWidget {
  const ButtonContainer({
    super.key,
    required String texto,
    required void Function() nav,
  })  : _nav = nav,
        _texto = texto;

  final void Function() _nav;
  final String _texto;

  @override
  State<ButtonContainer> createState() => _ButtonContainerState();
}

class _ButtonContainerState extends State<ButtonContainer> {
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
                  fontSize: MediaQuery.of(context).size.height * 0.05),
              padding: const EdgeInsets.all(25),
            ),
            child: Text(widget._texto,
                style: GoogleFonts.arimo(
                    color: ColorStyle.white, fontWeight: FontWeight.bold))));
  }
}
