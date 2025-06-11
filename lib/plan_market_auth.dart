import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class PlanMarketAuth with ChangeNotifier{
  String? message;
  String? token;

  final _url = "https://identitytoolkit.googleapis.com/";
  final _resource = "/v1/accounts";
  final _apiKey = "AIzaSyDMqk1S_fpBkMNZNvs2aeRI_bEQ4itYvS8";

  Future<bool> singUp (String email, String password) async {
    String sUri = '$_url$_resource:signUp?key=$_apiKey';
    Uri uri = Uri.parse(sUri);

    var response = await http.post(uri, body: {
      'email': email,
      'password': password,
      'returnSecureToken': 'true'
    });

    if (response.statusCode==200){
      message = "Cadastro realizdo com sucesso.";
      var body = jsonDecode(response.body);
      token = body['idToken'];
      return true;
    }else{
      message = "Erro ao cadastrar.";
      return false;
    }

  }
  Future<bool> singIn(String email, String password) async {
    String sUri = '$_url$_resource:signInWithPassword?key=$_apiKey';
    Uri uri = Uri.parse(sUri);

    var response = await http.post(uri, body:{
      'email': email,
      'password': password,
      'returnSecureToken': 'true'
    });

    if (response.statusCode==200){
      message = "User autenticado com sucesso.";
      var body = jsonDecode(response.body);
      token = body['idToken'];
      return true;
    }else{
      message = "Erro ao autenticar.";
      return false;
    }

  }

}