import 'package:google_fonts/google_fonts.dart';
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
          toolbarHeight: 100,
          automaticallyImplyLeading: false,
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Center(
          child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(color: Color(0xff001975)),
              padding: const EdgeInsets.fromLTRB(45, 60, 45, 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 15),
                    const Image(
                      image: AssetImage('images/logo_tcc.png'),
                      filterQuality: FilterQuality.high,
                      width: 100,
                    ),
                    const SizedBox(height: 25),
                    TextFormField(
                      controller: emailController,
                      autofocus: true,
                      keyboardType: TextInputType.emailAddress,
                      style: GoogleFonts.arimo(color: Colors.white, fontSize: 25),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.fromLTRB(0, 20, 0, 8),
                        labelText: 'Usuário ou e-mail',
                        labelStyle: GoogleFonts.arimo(color: Colors.white),
                        suffixIcon: const Image(
                          image: AssetImage('images/user.png'),
                          width: 15,
                          color: Colors.white,
                          alignment: Alignment.bottomRight,
                        ),
                        suffixIconConstraints: const BoxConstraints(
                          minWidth: 25, // Largura mínima do ícone
                          minHeight: 25, // Altura mínima do ícone
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                        controller: passwordController,
                        autofocus: true,
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        style:
                            GoogleFonts.arimo(color: Colors.white, fontSize: 25),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.fromLTRB(0, 20, 0, 8),
                          labelText: 'Senha',
                          labelStyle: GoogleFonts.arimo(color: Colors.white),
                          suffixIcon: const Image(
                            image: AssetImage('images/lock.png'),
                            width: 15,
                            color: Colors.white,
                            alignment: Alignment.bottomRight,
                          ),
                          suffixIconConstraints: const BoxConstraints(
                            minWidth: 25, // Largura mínima do ícone
                            minHeight: 25, // Altura mínima do ícone
                          ),
                        )),
                    const SizedBox(height: 60),
                    Container(
                        width: 350.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            gradient: const LinearGradient(colors: [
                              Color(0xff5de0e6),
                              Color(0xff004aad),
                            ])),
                        child: ElevatedButton(
                            // Button 'entrar'
                            onPressed: _onPressedButton,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              textStyle: const TextStyle(
                                  color: Colors.white, fontSize: 25),
                              padding: const EdgeInsets.all(25),
                            ),
                            child: Text('Entrar', style: GoogleFonts.arimo(color: Colors.white)))),
                    const SizedBox(height: 10),
                    const Text('OU',
                        style: TextStyle(fontSize: 22, color: Colors.white)),
                    const SizedBox(height: 10),
                    Container(
                        width: 350.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            gradient: const LinearGradient(colors: [
                              Color(0xff5de0e6),
                              Color(0xff004aad),
                              // 0xff5de0e6 - gradiente 1
                              // 0xff004aad - gradiente 2
                            ])),
                        child: ElevatedButton(
                            // Button 'cadastrar-se'
                            onPressed: () => {
                                  Navigator.of(context)
                                      .pushReplacementNamed('/cadastro'),
                                },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              textStyle: const TextStyle(
                                  color: Colors.white, fontSize: 25),
                              padding: const EdgeInsets.all(25),
                            ),
                            child: Text('Cadastrar-se', style: GoogleFonts.arimo(color: Colors.white)))),
                  ],
                ),
              )),
        ));
  }

  void _onPressedButton() {
    var loginController = LoginController(
        user: User(
            email: emailController.text, password: passwordController.text));
    if (loginController.isValid()) {
      Navigator.of(context)
          .pushReplacementNamed('/home'); // Manda pra tela inicial
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Login incorreto!!!'),
      ));

      emailController.clear();
      passwordController.clear();
    }
  }
}
