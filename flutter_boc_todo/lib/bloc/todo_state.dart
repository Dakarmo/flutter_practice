import 'package:equatable/equatable.dart';
import 'package:flutter_boc_todo/models/todos.dart';

class TodoState extends Equatable {
final List<Todos> todos;

const TodoState ({this.todos = const []});

  @override
  List<Object?> get props => [todos];

  TodoState copyWith({List<Todos>? todos}) {
    return TodoState(todos: todos ?? this.todos);
  }

}