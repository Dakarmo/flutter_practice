import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

String hashPassword(String password) {
  var bytes = utf8.encode(password); // Convertir le mot de passe en bytes
  var digest = sha256.convert(bytes); // Appliquer SHA-256
  return digest.toString(); // Retourne le hachage sous forme de chaîne hexadécimale
}

alertDialog(BuildContext context, String msg) {
  ToastContext().init(context);
  Toast.show(msg, duration: Toast.lengthShort, gravity:  Toast.bottom);
}

bool validateEmail(String email) {
  final emailReg = new RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9]{0,253}[a-zA-Z0-9)?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9]{0,253}[a-zA-Z0-9])?)*$");
  return emailReg.hasMatch(email);
}

bool validatePhoneNumber(String phoneNumber) {
  final phoneReg = RegExp(r"^\+[1-9]{1,3}(?:\d{2}){4}$");
  return phoneReg.hasMatch(phoneNumber);
}

const Color APP_COLOR = Color(0xff5b3bfe);

const int PAGE_LIMIT = 10;


enum SortTypes {
  ASC,
  DESC
}

enum GetTypes {
  FILTER,
  PAGING
}
