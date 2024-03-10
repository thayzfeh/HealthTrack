import 'dart:math';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login_tcc/components/colors.dart';
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

  bool _showWarning = false;

  final TextEditingController _textController = TextEditingController();
  void _showTextFieldDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Digite o código de 6 digitos recebido no email:'),
          content: TextField(
            controller: _textController,
            onChanged: (value) => validaCode(value),
            decoration: const InputDecoration(
              hintText: 'Digite aqui',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Salvar'),
            ),
            TextButton(
              onPressed: () {
                geraCodigo();
              },
              child: const Text('Gerar novo Código'),
            ),
          ],
        );
      },
    );
  }

  String emailUser = "";

  var appPassword1 = "";
  var appPassword2 = "";
  String texto = '';

  bool isCodeValid = false;

  void validaCode(String value) {
    if (value != codeAsString) {
      isCodeValid = false;
    } else {
      isCodeValid = true;
    }
  }

  final Email email = Email();
  void _sendEmail() async {
    final success = await email.sendMessage(
      emailUser,
      'Código de verificação de Email para o App Login_tcc: $codeAsString',
      'Código para acesso: $codeAsString',
    );

    if (success && isEmailValid == "true") {
      dialogoErro('E-mail enviado com sucesso!');
    } else {
      dialogoErro('Falha ao enviar o e-mail.');
    }
  }

  void dialogoErro(String texto) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(texto),
      ));
  }

  bool validDate = false;

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed("/login");
                        },
                        style: ElevatedButton.styleFrom(
                            alignment: Alignment.center,
                            backgroundColor: ColorStyle.background,
                            shadowColor: Colors.transparent,
                            padding: const EdgeInsets.fromLTRB(0, 0, 12, 0)),
                        child: const Icon(
                          Icons.arrow_back_ios,
                          size: 35,
                          color: ColorStyle.white,
                        ),
                      ),
                      const Image(
                        image: AssetImage('images/logo_tcc.png'),
                        filterQuality: FilterQuality.high,
                        width: 80,
                      ),
                      const SizedBox(
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
                    width: 350.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: const LinearGradient(colors: [
                          Color(0xff5de0e6),
                          Color(0xff004aad),
                        ])),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          // Validadores de informação
                          validador(context);
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        textStyle: const TextStyle(
                            color: ColorStyle.white, fontSize: 25),
                        padding: const EdgeInsets.all(25),
                      ),
                      child: Text(
                        'Cadastro',
                        style: GoogleFonts.arimo(color: ColorStyle.white),
                      ),
                    ),
                  )
                ])))));
  }

  void validador(BuildContext context) {
    if (validDate == false) {
      _showWarning = true;
      texto =
          "A data de nascimento está errada, deve ser dd/mm/aaaa";
    } else if (isEmailValid == "false") {
      _showWarning = true;
      texto = "O Email está invalido";
    } else if (isCodeValid == false) {
      geraCodigo();
      _sendEmail();
      _showTextFieldDialog(context);
    } else if (appPassword1 != appPassword2 ||
        appPassword1.length < 8) {
      _showWarning = true;
      texto = "Senhas não coincidem ou campo vazio";
    } else {
      _showWarning = false;
      texto = "";
      Navigator.of(context)
          .pushReplacementNamed("/login");
    }
  }
}

// Gerador de código de 6 digítos
final random = Random();
var sixDigitCode = 100000 + random.nextInt(900000);
String codeAsString = '$sixDigitCode';
void geraCodigo() {
  sixDigitCode = 100000 + random.nextInt(900000);
  codeAsString = '$sixDigitCode';
}

String isEmailValid = "";

// Responsável pelo envio do e-mail de verificação
class Email {
  final String username =
      'logintcc222@gmail.com'; // Email usado usado no envio do código
  final String appPassword = 'sqog pflp kzbu olsr'; // Senha do e-mail
  Future<bool> sendMessage(
      String recipient, String subject, String body) async {
    final smtpServer = gmail(username, appPassword);

    final message = Message()
      ..from = Address(username)
      ..recipients.add(recipient)
      ..subject = subject
      ..text = body;

    try {
      final sendReport = await send(message, smtpServer);
      isEmailValid = "true";
      // ignore: unnecessary_null_comparison
      return sendReport != null;
    } catch (e) {
      isEmailValid = "false";
      return false;
    }
  }
}
