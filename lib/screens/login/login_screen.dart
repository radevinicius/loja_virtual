import 'package:flutter/material.dart';
import 'package:loja_virtual_pro/helpers/validators.dart';
import 'package:loja_virtual_pro/models/user.dart';
import 'package:loja_virtual_pro/models/user_manager.dart';
import 'package:loja_virtual_pro/screens/login/singup/signup_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  _buttonPreview(double _height, double _width) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
        minimumSize: Size(_width, _height),
        padding: EdgeInsets.zero,
        foregroundColor: Colors.black);
    return TextButton(
      style: flatButtonStyle,
      onPressed: () {},
      child: const Text(
        "Esqueci minha senha",
      ),
    );
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/signup');
            },
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color.fromARGB(255, 4, 125, 141),
                elevation: 0),
            child: const Text(
              'Criar Conta',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 4, 125, 141),
        title: const Text('Entrar'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
              key: formKey,
              child: Consumer<UserManager>(builder: (_, userManager, __) {
                return ListView(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: <Widget>[
                    TextFormField(
                      enabled: !userManager.loading,
                      controller: emailController,
                      decoration: const InputDecoration(hintText: 'E-mail'),
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      validator: (email) {
                        if (!emailValid(email!)) return "E-mail inválido";
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      enabled: !userManager.loading,
                      controller: passwordController,
                      decoration: const InputDecoration(hintText: 'Senha'),
                      obscureText: true,
                      autocorrect: false,
                      validator: (pass) {
                        if (pass!.isEmpty || pass.length < 6)
                          return 'Senha Invalida';
                        return null;
                      },
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: _buttonPreview(5, 5),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 44,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              disabledBackgroundColor:
                                  Color.fromARGB(255, 4, 125, 141)
                                      .withAlpha(100),
                              backgroundColor: Color.fromARGB(255, 4, 125, 141),
                              padding: EdgeInsets.all(15)),
                          onPressed: userManager.loading
                              ? null
                              : (() {
                                  if (formKey.currentState!.validate()) {
                                    userManager.signIn(
                                        user: UserProfile(
                                            id: '',
                                            name: '',
                                            email: emailController.text,
                                            password: passwordController.text),
                                        onFail: (e) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content:
                                                  Text('Falha ao entrar: $e'),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        },
                                        onSucess: () {
                                          Navigator.of(context).pop();
                                        });
                                  }
                                }),
                          child: userManager.loading
                              ? const CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation(Colors.white),
                                )
                              : const Text(
                                  'Entrar',
                                  style: TextStyle(fontSize: 15),
                                )),
                    )
                  ],
                );
              })),
        ),
      ),
    );
  }
}
