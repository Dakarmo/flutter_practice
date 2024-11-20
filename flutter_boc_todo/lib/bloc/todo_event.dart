import "package:bloc/bloc.dart";
import "package:flutter_boc_todo/models/todos.dart";

abstract class TodoEvent {
  const TodoEvent();
}

class GetTodos extends TodoEvent {
  const GetTodos();
}

// class AddTodos extends TodoEvent {
//   const AddTodos({required this.name});
//
//   final String name;
// }
//
class AddTodos extends TodoEvent {
  const AddTodos({required this.todo});

  final Todos todo;
}

// class UpdateTodos extends TodoEvent {
//   const UpdateTodos({required this.id, required this.name});
//
//   final int id;
//   final String name;
// }

class UpdateTodos extends TodoEvent {
  const UpdateTodos({required this.todo});

  final Todos todo;
}

class DeleteTodos extends TodoEvent {
  const DeleteTodos({required this.todo});

  final Todos todo;
}

// class DeleteTodos extends TodoEvent {
//   const DeleteTodos({required this.id});
//
//   final int id;
// }