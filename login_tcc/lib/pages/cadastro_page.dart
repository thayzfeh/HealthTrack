import 'dart:math';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_tcc/components/buttons.dart';
import 'package:login_tcc/components/colors.dart';
import 'package:login_tcc/controllers/register_controller.dart';
import 'package:login_tcc/models/user.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  // Mascara (Formatação) para os Campos de Texto "Telefone" e "Data de Nascimento"
  final _phoneFormatter = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {'#': RegExp(r'[0-9]')},
  );

  final _dateFormatter = MaskTextInputFormatter(
    mask: "##/##/####",
    filter: {'#': RegExp(r'[0-9]')},
  );
  final _cpfFormatter = MaskTextInputFormatter(
    mask: "###.###.###-##",
    filter: {'#': RegExp(r'[0-9]')},
  );

  bool _showWarning = false;

  String emailUser = "";
  String nameUser = "";
  var appPassword1 = "";
  var appPassword2 = "";
  String texto = '';
  String phoneUser = '';
  String cpfUser = '';

  void dialogoErro(String texto) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(texto),
    ));
  }

  bool validDate = false;
  String isEmailValid = 'false';
  final TextEditingController dateController = TextEditingController();

  Object validateDate(String value) {
    try {
      final components = value.split('/');
      if (components.length != 3) {
        return 'Formato inválido. Use dd/mm/aaaa.';
      }
      final day = int.parse(components[0]);
      final month = int.parse(components[1]);
      final year = int.parse(components[2]);

      if (day < 1 || day > 31 || month < 1 || month > 12 || year < 1900) {
        return validDate = false;
      }
      return validDate = true; // Data válida
    } catch (e) {
      return validDate = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorStyle.background,
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height * 0.005,
          shadowColor: ColorStyle.background,
          backgroundColor: ColorStyle.background,
        ),
        body: Center(
            child: Container(
                height: double.infinity,
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(45, 20, 45, 0),
                color: ColorStyle.background,
                child: SingleChildScrollView(
                    child: Column(children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RetroButton(path: "/login"),
                      Image(
                        image: AssetImage('images/logo_tcc.png'),
                        filterQuality: FilterQuality.high,
                        width: 80,
                      ),
                      SizedBox(
                        width: 68,
                      )
                    ],
                  ),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    style: GoogleFonts.arimo(
                        color: ColorStyle.white, fontSize: 15),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(0, 20, 30, 8),
                      labelText: "Nome",
                      labelStyle: GoogleFonts.arimo(color: ColorStyle.white),
                    ),
                    onChanged: (value) => {
                      setState(() {
                        nameUser = value;
                      })
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.datetime,
                    controller: dateController,
                    onChanged: (value) => validateDate(value),
                    inputFormatters: [_dateFormatter],
                    style: GoogleFonts.arimo(
                        color: ColorStyle.white, fontSize: 15),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(0, 20, 30, 8),
                      labelText: 'Data de nascimento',
                      labelStyle: GoogleFonts.arimo(color: ColorStyle.white),
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    inputFormatters: [_phoneFormatter],
                    style: GoogleFonts.arimo(
                        color: ColorStyle.white, fontSize: 15),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(0, 20, 30, 8),
                      labelText: 'Telefone',
                      labelStyle: GoogleFonts.arimo(color: ColorStyle.white),
                    ),
                    onChanged: (value) {
                      setState(() {
                        phoneUser = value;
                      });
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [_cpfFormatter],
                    style: GoogleFonts.arimo(
                        color: ColorStyle.white, fontSize: 15),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(0, 20, 30, 8),
                      labelText: "CPF",
                      labelStyle: GoogleFonts.arimo(color: ColorStyle.white),
                    ),
                    onChanged: (value) => {
                      setState(() {
                        cpfUser = value;
                      })
                    },
                  ),
                  Form(
                    autovalidateMode: AutovalidateMode.always,
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: ((value) => EmailValidator.validate(value!)
                          ? isEmailValid = "true"
                          : isEmailValid = "false"),
                      onChanged: (value) {
                        emailUser = value;
                      },
                      style: GoogleFonts.arimo(
                          color: ColorStyle.white, fontSize: 15),
                      decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.fromLTRB(0, 20, 30, 8),
                          labelText: 'E-mail',
                          labelStyle:
                              GoogleFonts.arimo(color: ColorStyle.white),
                          hintText: "Coloque '.com' no final",
                          hintStyle: const TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 0.5))),
                    ),
                  ),
                  TextFormField(
                    onChanged: (value) {
                      appPassword1 = value;
                    },
                    keyboardType: TextInputType.visiblePassword,
                    style: GoogleFonts.arimo(
                        color: ColorStyle.white, fontSize: 15),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(0, 20, 30, 8),
                      labelText: 'Senha',
                      labelStyle: GoogleFonts.arimo(color: ColorStyle.white),
                    ),
                  ),
                  TextFormField(
                    initialValue: appPassword1,
                    onChanged: (value) {
                      appPassword2 = value;
                    },
                    keyboardType: TextInputType.visiblePassword,
                    style: GoogleFonts.arimo(
                        color: ColorStyle.white, fontSize: 15),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.fromLTRB(0, 20, 30, 8),
                      labelText: 'Confirmar senha',
                      labelStyle: GoogleFonts.arimo(color: ColorStyle.white),
                    ),
                  ),
                  if (_showWarning)
                    Text(
                      texto,
                      style: const TextStyle(color: Colors.red),
                    ),
                  const SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: const LinearGradient(colors: [
                          Color.fromARGB(255, 255, 255, 255),
                          Color.fromARGB(255, 226, 226, 226),
                        ])),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          validador(context);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        textStyle: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize:
                                MediaQuery.of(context).size.height * 0.045),
                        padding: const EdgeInsets.all(25),
                      ),
                      child: Text(
                        'Cadastro',
                        style: GoogleFonts.arimo(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ])))));
  }

  void validador(BuildContext context) async {
    if (validDate == false) {
      _showWarning = true;
      texto = "A data de nascimento está errada, deve ser dd/mm/aaaa";
    } else if (isEmailValid == "false") {
      _showWarning = true;
      texto = "O Email está invalido";
    } else if (appPassword1 != appPassword2 || appPassword1.length < 8) {
      _showWarning = true;
      texto = "Senhas não coincidem ou senha menor que 8 digitos";
    } else {
      _showWarning = false;
      texto = "";
      RegisterController novo_registro = RegisterController(
          user: User(
              email: emailUser,
              password: appPassword1,
              username: nameUser,
              birth: dateController.text,
              phone: phoneUser,
              cpf: cpfUser));
      if (await novo_registro.isValid(context)) {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    }
  }
}
