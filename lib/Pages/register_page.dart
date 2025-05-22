import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/auth_provider.dart';
import '../routes.dart';

class RegisterPage extends StatelessWidget {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final agreePasswordController = TextEditingController();

  void register(BuildContext context, String process) {
    String email = emailController.text;
    String password = passwordController.text;
    String agreePassword = agreePasswordController.text;

    if(password.isNotEmpty == true && agreePassword.isNotEmpty==true){
      if(password==agreePassword){
        AuthProvider authProvider = Provider.of<AuthProvider>(context, listen:false);
        authProvider.auth(process, email, password)
            .then((response) {
          if (response) {
            //toast de sucesso
            print(authProvider.message);
            Navigator.pushNamed(context, Routes.LOGIN);
          } else {
            print(authProvider.message);
            //toast faild
          }
        });
      }
    }else{
      // toast para preencher campo de senhas
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),

      body: Center(
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
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: TextField(
                          controller: agreePasswordController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Confirme Senha',
                            hintText: 'Confirme a Senha',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    register(context, 'signUp?key=');
                  }, child: Text("Registrar"),
                ),
              ]
          ),
        ),
      ),
    );
  }
}