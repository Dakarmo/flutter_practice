import 'package:flutter/material.dart';
import 'package:flutter_boc_todo/bloc/todo_bloc.dart';
import 'package:flutter_boc_todo/home/home_view.dart';
import 'package:flutter_boc_todo/repositories/todo_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TodoBloc(todoRepository: TodoRepository()),
        child: const HomeView()
    );
  }
}

