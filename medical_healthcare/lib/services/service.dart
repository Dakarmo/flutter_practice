import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Service {
  // creation de la méthode pour enrégister un utilisateur
final localUrl = 'http://172.18.160.1:8080';
  Future<http.Response> saveUser (String name, String email,String mobile, String password) async{
    //creation de l'url
    // var  url =  Uri.parse("http://172.18.160.1:8080/register");
    var  url =  Uri.parse("http://172.31.0.1:8080/register");
    //header
    Map<String, String> headers = {"Content-Type": "application/json"};
    //body
    Map data = {
      'name' : '$name',
      'email' : '$email',
      'mobile' : '$mobile',
      'password': '$password'
    };

    // conversion de la data ci-dessus en json
    var body = json.encode(data);
    var response = await http.post(url, headers: headers, body: body );

    //affichage de la response body

    print("${response.body}");
    return response;
  }

Future<Map<String, dynamic>> loginUser(String email, String password) async {
  // Créez l'URL de l'API
  var url = Uri.parse('http://172.31.0.1:8080/login'); // Remplacez <votre_adresse_IP> par votre IP

  // Créez le corps de la requête
  Map<String, String> body = {
    'email': email,
    'password': password,
  };

  // Créez l'en-tête de la requête
  Map<String, String> headers = {
    'Content-Type': 'application/json',
  };

  try {
    // Effectuez la requête HTTP POST
    var response = await http.post(url, headers: headers, body: json.encode(body));
// print(response.statusCode);
    // Vérifiez le statut de la requête
    if (response.statusCode == 200) {
      // Si la connexion est réussie, retournez les données de l'utilisateur
      return {
        'status': 'success',
        'data': json.decode(response.body),
      };
    } else {
      // En cas d'erreur, retournez le message d'erreur
      return {
        'status': 'error',
        'message': json.decode(response.body)['message'],
      };
    }
  } catch (e) {
    return {
      'status': 'error',
      'message': 'Erreur de connexion au serveur',
    };
  }
}


}