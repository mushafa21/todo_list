import 'package:flutter/material.dart';
import 'package:to_do_list/model/todo.dart';

class AddTodoDialog extends StatelessWidget {
  final Function(Todo) onCreated;
   AddTodoDialog({Key? key, required this.onCreated}) : super(key: key);

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(

            ),
            controller: _titleController,
          ),
          TextField(
            decoration: InputDecoration(

            ),
            controller: _descController,
          ),
          SizedBox(height: 10,),
          ElevatedButton(onPressed: (){
            onCreated(Todo(id: null, title: _titleController.text, description: _descController.text, done: false));
          }, child: Text("Tambah Todo"))
        ],
      ),
    );
  }
}
