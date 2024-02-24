import 'package:flutter/material.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({Key? key}) : super(key: key);

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                color: const Color(0xff001975),
                child: Column(children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(color: Colors.white, fontSize: 25),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(0, 20, 30, 8),
                      labelText: 'Nome',
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                  )
                ]))));
  }
}
