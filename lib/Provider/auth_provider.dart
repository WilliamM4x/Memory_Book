import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier{
 String? message;
 String? token;
 late int status;

 final _url = "https://identitytoolkit.googleapis.com/";
 final _resource = "/v1/accounts:";
 final _apiKey='AIzaSyBgZVbRcznR0r-os_WbYT7va6useDrFwkY';

 Future<bool> auth (String process,String email,String password) async {
   String sUri = '$_url$_resource$process${_apiKey}';
   Uri uri = Uri.parse(sUri);

    var response = await http.post(uri, body:{
      'email': email,
      'password': password,
      'returnSecureToken': 'true'
    });

    if(response.statusCode == 200){
     message = "Sucesso.";
     var body = jsonDecode(response.body);
     token = body['idToken'];
     return true;
    }else{
     message = "Error.${response.statusCode}";
     return false;
    }


 }

 Future<bool> recoveryPas(String email, BuildContext context) async{
   String sUri = '$_url${_resource}sendOobCode?key=${_apiKey}';
   Uri uri = Uri.parse(sUri);

   var response = await http.post(uri, body:{
      'email': email,
      'requestType': 'PASSWORD_RESET'
   });

   if(response.statusCode == 200){

     //var status = response.statusCode;
     message = "Link de recuperação enviado com sucesso.";
     Navigator.pop(context);
     return true;
   }else{
      message = "Error.${response.statusCode}";
      return false;
   }

 }

}