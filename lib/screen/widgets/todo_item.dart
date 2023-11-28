import 'package:flutter/material.dart';
import 'package:to_do_list/model/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo data;
  final Function(Todo) onDelete;
  final Function(Todo) onUpdate;
  const TodoItem({Key? key, required this.data, required this.onDelete, required this.onUpdate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ListTile(
      title: Text(data.title),
      subtitle:Text(data.description),
      leading: IconButton(icon: Icon(data.done ? Icons.check_circle : Icons.circle),onPressed: (){
        onDelete(data);
      },),
      trailing: IconButton(icon: Icon(Icons.delete),onPressed: (){
        onDelete(data);
      },),
    );
  }
}
