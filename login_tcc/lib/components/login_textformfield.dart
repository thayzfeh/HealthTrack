import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_tcc/components/colors.dart';

class LoginTextFormField extends StatefulWidget {
  const LoginTextFormField({
    super.key,
    required TextEditingController controller,
    required TextInputType? keyboardType,
    required String text,
    required String asset,
    required bool isPassword,
  })  : _controller = controller,
        _keyboardType = keyboardType,
        _text = text,
        _asset = asset,
        _isPassword = isPassword;

  final TextEditingController _controller;
  final TextInputType? _keyboardType;
  final String _text;
  final String _asset;
  final bool _isPassword;

  @override
  State<LoginTextFormField> createState() => _LoginTextFormFieldState();
}

class _LoginTextFormFieldState extends State<LoginTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget._controller,
      autofocus: true,
      keyboardType: widget._keyboardType,
      obscureText: widget._isPassword ? true : false,
      style: GoogleFonts.arimo(
          color: ColorStyle.white,
          fontSize: MediaQuery.of(context).size.height * 0.025),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(
            0,
            MediaQuery.of(context).size.height * 0.03,
            0,
            MediaQuery.of(context).size.height * 0.01),
        labelText: widget._text,
        labelStyle: GoogleFonts.arimo(color: ColorStyle.white),
        suffixIcon: Image(
          image: AssetImage(widget._asset),
          width: 15,
          color: ColorStyle.white,
          alignment: Alignment.bottomRight,
        ),
        suffixIconConstraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width *
              0.07, // Largura mínima do ícone
          minHeight: MediaQuery.of(context).size.height *
              0.07, // Altura mínima do ícone
        ),
      ),
    );
  }
}
