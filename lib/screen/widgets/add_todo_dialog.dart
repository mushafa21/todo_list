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
      padding: EdgeInsets.all(16),
      height: 400,
      child: Column(

        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Tambah Todo",style: TextStyle(fontSize: 20),),
          SizedBox(height: 10,),

          TextField(

            decoration: InputDecoration(
              hintText: "Masukan judul",
              labelText: "Judul",
              border: OutlineInputBorder()

            ),
            controller: _titleController,
          ),
          SizedBox(height: 10,),

          TextField(
            decoration: InputDecoration(
                hintText: "Masukan deskripsi",
                labelText: "Deskripsi",
                border: OutlineInputBorder()


            ),
            controller: _descController,
          ),
          SizedBox(height: 20,),
          ElevatedButton(onPressed: (){
            if(_titleController.text.isNotEmpty && _descController.text.isNotEmpty){
              Navigator.pop(context);
              onCreated(Todo(id: null, title: _titleController.text, description: _descController.text, done: false));
            }
          }, child: Text("Tambah Todo"))
        ],
      ),
    );
  }
}
