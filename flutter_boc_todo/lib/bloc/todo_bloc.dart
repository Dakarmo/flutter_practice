import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boc_todo/bloc/todo_event.dart';
import 'package:flutter_boc_todo/bloc/todo_state.dart';

import 'package:flutter_boc_todo/repositories/todo_repository.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState>{
  TodoBloc({required this.todoRepository}): super(const TodoState()) {
    on<GetTodos>(_getTodos);
    on<AddTodos>(_addTodos);
    on<UpdateTodos>(_updateTodos);
    on<DeleteTodos>(_deleteTodos);
  }

  final TodoRepository todoRepository;

  Future<void> _getTodos(GetTodos event, Emitter<TodoState> emit) async{
    try{
      final result = await todoRepository.getAllTodos();
      emit(state.copyWith(todos: result));
    }catch(e){
      debugPrint('There was an issue getting todo');
    }
  }
  Future<void> _addTodos(AddTodos event, Emitter<TodoState> emit) async{
    print('La donnée est envoyée : ${event.todo}');
    try{
      final result = await todoRepository.addTodo(event.todo);
      emit(state.copyWith(todos: [...state.todos, result]));
    }catch(e){
      debugPrint('There was an issue adding todo');
    }
  }
  Future<void> _updateTodos(UpdateTodos event, Emitter<TodoState> emit) async{
    try{
      final result = await todoRepository.editTodo(event.todo);
      final updatedTodos = state.todos.map((todo) {
        return todo.id == result.id ? result : todo;
      }).toList();
      emit(state.copyWith(todos: updatedTodos));
    }catch(e){
      debugPrint('There was an issue updating todo');
    }

  }
  Future<void> _deleteTodos(DeleteTodos event, Emitter<TodoState> emit) async{
    try{
      await todoRepository.deleteTodo(event.todo);
      final result = await todoRepository.deleteTodo(event.todo);
      final deleteTodos = state.todos.where((todo) => todo.id != event.todo.id).toList();

      emit(state.copyWith(todos: deleteTodos));

    }catch(e){
      debugPrint('There was an issue deleting todo');
    }
  }

}