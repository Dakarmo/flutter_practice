class Todos {
   int? id;
   String? name;

  Todos({required this.id, required this.name});

  Todos.empty();

  factory Todos.fromJson(Map<String, dynamic> json) {
    return Todos(
        id: json['id'],
        name: json['name'],
    );
  }

  Map<String, dynamic> toJson(Todos todo) {
    return {
      "id": todo.id,
      "name": todo.name,
    };
  }

  @override
  String toString() {

    return 'Todo{'
        'id: $id,'
        'name: $name,}';
  }
}