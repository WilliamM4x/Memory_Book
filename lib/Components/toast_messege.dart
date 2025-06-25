import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToastMessage(String message) {
  Fluttertoast.showToast(
    msg: message, // Mensagem
    toastLength: Toast.LENGTH_SHORT, // Duração (pode ser LONG)
    gravity: ToastGravity.BOTTOM, // Posição (CENTER, TOP, BOTTOM)
    timeInSecForIosWeb: 1, // Duração para iOS e Web
    backgroundColor: Colors.black.withOpacity(0.7), // Cor de fundo
    textColor: Colors.white, // Cor do texto
    fontSize: 16.0, // Tamanho da fonte
  );
}