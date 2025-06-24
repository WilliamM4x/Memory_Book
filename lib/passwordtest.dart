import 'package:flutter/material.dart';

enum FeedbackStrongPass{
  invalida(message: "A senha precisa ter 8 caracteres ou mais.", color: Colors.black, validate: false),
  fraca(message: "Senha fraca.",color: Colors.red, validate: false),
  moderada(message: "Senha moderada.", color: Colors.yellow, validate: true),
  forte(message: "Senha forte.",color: Colors.green,validate: true);
  const FeedbackStrongPass({required this.message, required this.color, required this.validate});
  final String message;
  final Color color;
  final bool validate;
}

class PassTest {
  FeedbackStrongPass checarForca(String password) {
    if (password.length < 8) {
      return FeedbackStrongPass.invalida;
    }

    final bool temMaiuscula = RegExp(r'[A-Z]').hasMatch(password);
    final bool temMinuscula = RegExp(r'[a-z]').hasMatch(password);
    final bool temNumero = RegExp(r'\d').hasMatch(password);
    final bool temEspecial = RegExp(r'[@$!%*?&]').hasMatch(password);

    int pontuacao = 0;
    if (temMaiuscula) pontuacao++;
    if (temMinuscula) pontuacao++;
    if (temNumero) pontuacao++;
    if (temEspecial) pontuacao++;


    if (pontuacao <= 2) {
      return FeedbackStrongPass.fraca;
    } else if (pontuacao == 3) {
      return FeedbackStrongPass.moderada;
    } else { // pontuacao == 4
      return FeedbackStrongPass.forte;
    }
  }
}