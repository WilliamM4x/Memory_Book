import 'package:flutter/material.dart';
import 'package:memory_book/Provider/auth_provider.dart';
import 'package:provider/provider.dart';

import '../routes.dart';

class LoginPage extends StatelessWidget{
  LoginPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void login (BuildContext context, String process) {
    String email= emailController.text;
    String password = passwordController.text;
    if(email.isNotEmpty || password.isNotEmpty) {
      AuthProvider authProvider = Provider.of<AuthProvider>(
          context, listen: false);
      authProvider.auth(process, email, password).then((response) async {
        if (response) {
          final snackBar = SnackBar(
            content: Text("Bem-vindo ao Memory Book"),
            backgroundColor: Colors.green[400],
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          await Future.delayed(const Duration(seconds: 2));

          Navigator.pushNamed(context, Routes.DASHBOARD);
        } else {
          final snackBar = SnackBar(
            content: Text("${authProvider.message
                .toString()}! Verifique seus dados ou realize o cadastro."),
            backgroundColor: Colors.green[400],
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },);
    }else{
      final snackBar = SnackBar(
        content: Text("Preencha o email e a senha."),
        backgroundColor: Colors.green[400],
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body:SafeArea(
        child: Center(
        child: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                       border: OutlineInputBorder(),
                       hintText: 'E-mail',
                       labelText: 'E-mail',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Senha',
                        hintText: 'Senha',
                      ),
                    ),
                  ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  login(context, 'signInWithPassword?key=');
                },child: Text("Login"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.REGISTER);
                },child: Text("Cadastro"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.FORGOT_PASSWORD);
                },child: Text("Esqueci a senha"),
              ),
            ]
          ),
        ),
      ),),
    );
  }

}