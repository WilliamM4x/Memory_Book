import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PlanMarketAuth with ChangeNotifier {

  String? message = null;
  String? token = null;

  String _url = "https://identitytoolkit.googleapis.com/";
  String _resource = "/v1/accounts";
  String _apiKey = "AIzaSyDMqk1S_fpBkMNZNvs2aeRI_bEQ4itYvS8";

  Future<bool> singUp(String email, String senha) async {
      String string_uri = '$_url$_resource:singUp?key=$_apiKey';
      Uri uri= Uri.parse(string_uri);

      var response = await http.post(
        uri,
        body: json.encode({
          'email': email,
          'password': senha,
          'returnSecureToken': 'true'
        }),
      );

      if (response.statusCode == 200){
        message = "Cadastro realizdo com sucesso.";
        var body = jsonDecode(response.body);
        token = body['idToken'];
        return true;
      } else {
        message = "Erro ao cadastrar.";
        return false;
      }
  }


  Future<bool> singIn(String email, String senha) async {
    String string_uri = '$_url$_resource:singInWithPassword?key=$_apiKey';
    Uri uri= Uri.parse(string_uri);

    var response = await http.post(
      uri,
      body: json.encode({
        'email': email,
        'password': senha,
        'returnSecureToken': 'true'
      }),
    );

    if (response.statusCode == 200){
      message = "Login realizado com sucesso.";
      var body = jsonDecode(response.body);
      token = body['idToken'];
      return true;
    } else {
      message = "Erro ao realizar login.";
      return false;
    }

  }
}
