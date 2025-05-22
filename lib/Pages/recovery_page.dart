
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/auth_provider.dart';

class RecoveryPage extends StatelessWidget{

  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
   return Scaffold(
       appBar: AppBar(
         title: Text('Recuperar senha'),
         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
       ),
       body: Center(
         child: SingleChildScrollView(
           reverse: true,
           child: Column(
             children: [
               Padding(
                   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                   child: Column(
                     children: [
                       TextField(
                         controller: emailController,
                         decoration: InputDecoration(
                           labelText: 'E-mail',
                           hintText: 'Email de recuperação',
                         ),
                       ),
                     ],
                   )
               ),
                ElevatedButton(
                  onPressed: () {
                     var email = emailController.text,
                     authProvider = Provider.of<AuthProvider>(context, listen: false);
                     authProvider.recoveryPas(email, context);
                     // adicionar toast com a menssage do provider

                  },
                  child: Text("Enviar"),
                ),
             ],
           ),
         )
       ),
   );
  }
}