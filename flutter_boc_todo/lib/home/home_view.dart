import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_boc_todo/bloc/todo_bloc.dart';
import 'package:flutter_boc_todo/bloc/todo_event.dart';
import 'package:flutter_boc_todo/bloc/todo_state.dart';
import 'package:flutter_boc_todo/home/widgets/add_todo.dialog.dart';
import 'package:flutter_boc_todo/models/todos.dart';


// final todos = [
//   Todos(id: 0, name: 'first todo'),
//   Todos(id: 1, name: 'second todo')
// ];
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  @override
  void initState() {

    super.initState();
    context.read<TodoBloc>().add(const GetTodos());
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TodoBloc>();
    return  BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () =>  showAddTodoDialog(context, bloc),
            child: const Icon(Icons.add_rounded),
          ),
          body: Container(
            padding: const EdgeInsets.all(20),
            child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                        'Todo app with flutter bloc',
                      style: Theme.of(context).textTheme.headlineSmall,
                    )
                  ),
                  const SizedBox(height: 15),
                  ...state.todos.map(
                    (todo) => Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      width: double.infinity,
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            todo.name!,
                            style: TextStyle(color: Colors.white),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: (){
                                  showAddTodoDialog(context,bloc, updatedTodo: todo);
                                },  icon: Icon(Icons.edit)),
                              SizedBox(width: 15),
                              IconButton(
                                  onPressed: (){
                                    context.read<TodoBloc>().add(DeleteTodos(todo: todo));
                                  },  icon: Icon(Icons.delete)),
                            ],
                          )
                        ],
                      ),
                    )
                  )
                ]
            ),
          ),
        );
      }
    );
  }

  void showAddTodoDialog(BuildContext context, TodoBloc bloc, {Todos? updatedTodo}){

    showDialog(
      context: context,
      builder: (context) => AddTodoDialog(
        onTodoAdded: (name, ) {

          final todo = Todos(
            id: updatedTodo?.id,
            name: name,
          );

          if(updatedTodo == null) {
            return bloc.add(AddTodos(todo: todo));
          }
          bloc.add(UpdateTodos(todo: todo));


        },
          updatedTodo: updatedTodo
      ),
    );
  }


}


