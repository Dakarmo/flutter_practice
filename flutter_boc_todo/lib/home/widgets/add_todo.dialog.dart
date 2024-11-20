import 'package:flutter/material.dart';
import 'package:flutter_boc_todo/models/todos.dart';

class AddTodoDialog extends StatelessWidget {
  final Function(String) onTodoAdded;
  final Todos? updatedTodo;
  const AddTodoDialog({super.key, required this.onTodoAdded, this.updatedTodo});

  @override
  Widget build(BuildContext context) {
    TextEditingController todoNameController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    
    return AlertDialog(
      content: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: todoNameController,
                    decoration: InputDecoration(
                      hintText: updatedTodo != null ? updatedTodo?.name : 'Todo name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Le champs ne peut pas être vide';
                      }
                      return null; // Pas d'erreur si le champ n'est pas vide
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),
            ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    Navigator.of(context).pop();
                    onTodoAdded(todoNameController.text);
                  }
                },
              label: Text('Confirm'),
              icon: Icon(Icons.check),
            )
          ],

        ),
      ),
    );
  }
}
