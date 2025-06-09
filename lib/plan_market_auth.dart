import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PlanMarketAuth with ChangeNotifier {

  String? _message = null;
  String? _token = null;

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
        _message = "Cadastro realizdo com sucesso.";
        var body = jsonDecode(response.body);
        _token = body['idToken'];
        return true;
      } else {
        _message = "Erro ao cadastrar.";
        return false;
      }
  }


  Future<bool> singIn(String email, String senha) async {
    String string_uri = '$_url$_resource:singInWhithPassword?key=$_apiKey';
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
      _message = "Login realizado com sucesso.";
      var body = jsonDecode(response.body);
      _token = body['idToken'];
      return true;
    } else {
      _message = "Erro ao realizar login.";
      return false;
    }

  }
}
