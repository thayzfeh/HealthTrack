import 'package:login_tcc/controllers/login_controller.dart';
import 'package:login_tcc/models/user.dart';
import 'package:flutter/material.dart';

class LoginPageCopy extends StatefulWidget {
  const LoginPageCopy({super.key});

  @override
  State<LoginPageCopy> createState() => _LoginPageCopyState();
}

class _LoginPageCopyState extends State<LoginPageCopy> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 100,
        title: const Image(
          image: AssetImage('images/soul.png'),
          width: 65,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 27),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff39235c),
                Color(0xff523173),
                Color(0xff6e418b),
                Color(0xff8c52a2),
                Color(0xffac66b9),
                Color(0xffcd7cd0),
                Color(0xffe893e2),
                Color(0xffffadf0),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              const Text(
                "Digite os dados de acesso nos campos abaixo.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: emailController,
                autofocus: true,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Colors.blue, fontSize: 30),
                decoration: const InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: passwordController,
                autofocus: true,
                keyboardType: TextInputType.text,
                obscureText: true,
                style: const TextStyle(color: Colors.blue, fontSize: 30),
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  labelStyle: TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    onPressed: _onPressedButton,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      textStyle:
                          const TextStyle(color: Colors.white, fontSize: 20),
                      padding: const EdgeInsets.all(18),
                    ),
                    child: const Text('Acessar')),
              ),
              const SizedBox(height: 7),
              Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white70, width: 0.8),
                      borderRadius: BorderRadius.circular(7)),
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        textStyle:
                            const TextStyle(color: Colors.white, fontSize: 20),
                        padding: const EdgeInsets.all(18),
                      ),
                      child: const Text('Criar minha conta'))),
            ],
          ),
        ),
      ),
    );
  }

  void _onPressedButton() {
    var loginController = LoginController(
        user: User(
            email: emailController.text, password: passwordController.text));
    if (loginController.isValid()) {
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Login incorreto!!!'),
      ));

      emailController.clear();
      passwordController.clear();
    }
  }
}
