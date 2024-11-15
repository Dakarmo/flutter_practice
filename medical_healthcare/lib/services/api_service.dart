import 'package:http/http.dart' as http;
import 'dart:convert';

class APIService {
  final String _urlLocal = 'http://172.18.160.1:8080';

  Map<String, String> _headers = {
    "content-type": "appication/json",
    "accept": "appication/json",
  };

  Future<http.Response> get(String url, Map<String, String> params) async{
    try {
      Uri uri= Uri.parse(_urlLocal+url).replace(queryParameters: params);
      http.Response response = await http.get(uri);
      return response;
    }catch(e){
      return http.Response({'message': e}.toString(), 400);
    }
  }

  Future<http.Response> post(String url, Map<String, dynamic> body) async{
      try {
        Uri uri= Uri.parse(_urlLocal+url);
        String bodyString = json.encode(body);
        http.Response response = await http.post(uri, headers: _headers, body: bodyString);
        return response;
      }catch(e){
        return http.Response({'message': e}.toString(), 400);
      }
  }

  Future<http.Response> put(String url, Map<String, dynamic> body) async{
      try {
        Uri uri= Uri.parse(_urlLocal+url);
        String bodyString = json.encode(body);
        http.Response response = await http.put(uri, headers: _headers, body: bodyString);
        return response;
      }catch(e){
        return http.Response({'message': e}.toString(), 400);
      }
  }

  Future<http.Response> delete(String url) async{
      try {
        Uri uri= Uri.parse(_urlLocal+url);

        http.Response response = await http.delete(uri, headers: _headers);
        return response;
      }catch(e){
        return http.Response({'message': e}.toString(), 400);
      }
  }



}