import 'package:flutter/material.dart';
import 'package:passwordtest/passwordtest.dart';
import 'package:provider/provider.dart';
import '../Components/toast_messege.dart';
import '../Provider/auth_provider.dart';

import '../routes.dart';


class RegisterPage extends StatefulWidget{
  const RegisterPage({Key? key}) : super(key: key);


  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {


  //Pegando do pacote
  PassTest verifyPassword = PassTest();
  FeedbackStrongPass _forcaDaSenha = FeedbackStrongPass.invalida;

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
            showToastMessage(authProvider.message.toString());
            Navigator.pushNamed(context, Routes.LOGIN);
          } else {
            print(authProvider.message);
            showToastMessage("authProvider.message.toString()");
          }
        });
      }else{
        final snackBar = SnackBar(
          content: Text("As senhas não coincidem"),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }else{
      final snackBar = SnackBar(
        content: Text("Confirme sua senha"),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                          onChanged: (password) {
                            setState(() {
                              _forcaDaSenha = verifyPassword.checarForca(password);
                            });
                          },),

                      ),
                      Text(
                        _forcaDaSenha.message,
                        style: TextStyle(color: _forcaDaSenha.color, fontWeight: FontWeight.bold),
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
                  onPressed: _forcaDaSenha.validate? (){
                  register(context, 'signUp?key=');
                  }: null,
                child: Text("Registrar"),
                ),
              ]
          ),
        ),
      ),
    );
  }
}