import 'package:login_tcc/components/buttons.dart';
import 'package:login_tcc/components/colors.dart';
import 'package:login_tcc/components/login_textformfield.dart';
import 'package:login_tcc/controllers/login_controller.dart';
import 'package:login_tcc/models/user.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height * 0.1,
          automaticallyImplyLeading: false,
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Center(
          child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(color: ColorStyle.background),
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * 0.1,
                    MediaQuery.of(context).size.height * 0.08,
                    MediaQuery.of(context).size.width * 0.1,
                    MediaQuery.of(context).size.height * 0.08),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 15),
                    Image(
                      image: const AssetImage('images/logo_tcc.png'),
                      filterQuality: FilterQuality.high,
                      width: MediaQuery.of(context).size.width * 0.25,
                    ),
                    const SizedBox(height: 25),
                    LoginTextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      text: 'Usuário ou e-mail',
                      asset: 'images/user.png',
                      isPassword: false,
                    ),
                    const SizedBox(height: 5),
                    LoginTextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        text: 'Senha',
                        asset: 'images/lock.png',
                        isPassword: true),
                    const SizedBox(height: 60),
                    PrimaryButton(texto: "Entrar", nav: _onPressedLogin),
                    const SizedBox(height: 10),
                    const Text('OU',
                        style:
                            TextStyle(fontSize: 22, color: ColorStyle.white)),
                    const SizedBox(height: 10),
                    PrimaryButton(
                        texto: 'Cadastrar-se', nav: _onPressedCadastro),
                  ],
                ),
              )),
        ));
  }

  Future<void> _onPressedLogin() async {
    var loginController = LoginController(
        user: User(
            email: emailController.text, password: passwordController.text));
    if (await loginController.isValid(context)) {
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      emailController.clear();
      passwordController.clear();
    }
  }

  void _onPressedCadastro() {
    Navigator.of(context).pushReplacementNamed('/cadastro');
  }
}
