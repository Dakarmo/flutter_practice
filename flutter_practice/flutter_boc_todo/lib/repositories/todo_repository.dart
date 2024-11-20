import 'package:flutter_boc_todo/models/todos.dart';
import 'package:flutter_boc_todo/services/api_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class TodoRepository {
  final APIService _apiService = APIService();

  Future<List<Todos>> getAllTodos() async{
    http.Response response = await _apiService.get("/todos");

    dynamic responseJson = jsonDecode(response.body);
    print(responseJson);
    final jsonData=responseJson["data"] as List;
    print(jsonData);
    List<Todos> getTodo = jsonData.map((todo) => Todos.fromJson(todo)).toList();
    return getTodo;

  }

  Future<Todos> addTodo(Todos todo) async{
    http.Response response = await _apiService.post("/todos/add", todo.toJson(todo));

    dynamic responseJson = jsonDecode(response.body);
    print(responseJson);
    final jsonData=responseJson["data"];
    print(jsonData);
    Todos savedTodo = Todos.fromJson(jsonData);
    return savedTodo;

  }

  Future<Todos> editTodo(Todos todo)  async{

    http.Response response = await _apiService.put("/todos/edit", todo.toJson(todo));
    dynamic responseJson = jsonDecode(response.body);
    final jsonData=responseJson["data"];
    Todos editTodo = Todos.fromJson(jsonData);
    return editTodo;
  }

  Future<dynamic> deleteTodo(Todos todo) async{
    http.Response response = await _apiService.delete("/todos/delete/${todo.id}");

    dynamic responseJson = jsonDecode(response.body);
    final jsonMessage = responseJson["message"];


  }
}