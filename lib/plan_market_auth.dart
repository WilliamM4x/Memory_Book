import 'package:flutter/material.dart';

class PlanMarketAuth with ChangeNotifier {

  String? _message = null;
  String? _token = null;

  String _url = "https://identitytoolkit.googleapis.com/";
  String _resource = "/v1/accounts";
  String _apiKey = "AIzaSyDMqk1S_fpBkMNZNvs2aeRI_bEQ4itYvS8";

  void singUp(){

  }
  void singIn(){
  }
}
