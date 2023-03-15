import 'package:firebase_auth/firebase_auth.dart';
import 'package:loja_virtual_pro/models/user.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_pro/helpers/validators.dart';
import 'package:loja_virtual_pro/models/user_manager.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  final UserProfile user =
      UserProfile(email: '', password: '', name: '', id: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 4, 125, 141),
        title: const Text('Criar Conta'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(
              builder: (_, userManager, __) {
                return ListView(
                  padding: const EdgeInsets.all(16),
                  shrinkWrap: true,
                  children: <Widget>[
                    TextFormField(
                      decoration:
                          const InputDecoration(hintText: 'Nome Completo'),
                      enabled: !userManager.loading,
                      validator: (name) {
                        if (name!.isEmpty) {
                          return "Campo Obrigatório";
                        } else if (name.trim().split(' ').length <= 1) {
                          return "Preencha seu nome completo";
                        }
                        return null;
                      },
                      onSaved: (name) => user.name = name!,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      enabled: !userManager.loading,
                      decoration: const InputDecoration(hintText: 'E-mail'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (email) {
                        if (email!.isEmpty) {
                          return "Campo Obrigatorio";
                        } else if (!emailValid(email)) {
                          return "E-mail Inválido";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (email) => user.email = email!,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      enabled: !userManager.loading,
                      decoration: const InputDecoration(hintText: 'Senha'),
                      obscureText: true,
                      validator: (pass) {
                        if (pass!.isEmpty) {
                          return "Senha obrigatória";
                        } else if (pass.length < 6) {
                          return "Senha muito curta";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (pass) => user.password = pass!,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      enabled: !userManager.loading,
                      decoration:
                          const InputDecoration(hintText: 'Repita a Senha'),
                      obscureText: true,
                      validator: (pass) {
                        if (pass!.isEmpty) {
                          return "Senha obrigatória";
                        } else if (pass.length < 6) {
                          return "Senha muito curta";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (pass) => user.confirmPassword = pass!,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                        height: 44,
                        child: ElevatedButton(
                            onPressed: userManager.loading
                                ? null
                                : () {
                                    if (formKey.currentState!.validate()) {}
                                    formKey.currentState!.save();
                                    if (user.password != user.confirmPassword) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text('Senhas não coincidem.'),
                                        backgroundColor: Colors.red,
                                      ));
                                      return;
                                    }
                                    userManager.signUp(
                                        user: user,
                                        onFail: (e) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Falha ao cadastrar: $e'),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        },
                                        onSucess: () {
                                          Navigator.of(context).pop();
                                        });
                                  },
                            style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor:
                                    const Color.fromARGB(255, 4, 125, 141),
                                elevation: 0),
                            child: userManager.loading
                                ? const CircularProgressIndicator(
                                    valueColor:
                                        AlwaysStoppedAnimation(Colors.white),
                                  )
                                : const Text(
                                    'Criar Conta',
                                    style: TextStyle(fontSize: 18),
                                  ))),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
