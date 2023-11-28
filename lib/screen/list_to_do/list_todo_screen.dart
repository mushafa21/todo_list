import 'package:flutter/material.dart';
import 'package:to_do_list/screen/widgets/todo_item.dart';

import '../../model/todo.dart';
import 'package:to_do_list/app/app.dart' as app;

import '../widgets/add_todo_dialog.dart';


class ListTodoScreen extends StatefulWidget {
  const ListTodoScreen({Key? key}) : super(key: key);

  @override
  State<ListTodoScreen> createState() => _ListTodoScreenState();
}

class _ListTodoScreenState extends State<ListTodoScreen> {

  List<Todo> listTodo = [];

  showCreateTodoDialog(){
    showDialog(context: context, builder: (BuildContext context) {
      return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)), //this right here
          child: AddTodoDialog(onCreated: addTodoList));});
  }



  searchTodo(String keyword) async{
    if(keyword.isNotEmpty){
      listTodo = await app.database?.todoDao.getAllByName(keyword) ?? [];
      setState(() {

      });
    } else{
      getTodoList();
    }
  }


  getTodoList() async{
    listTodo = await app.database?.todoDao.getAll() ?? [];
    setState(() {

    });
  }

  addTodoList(Todo data) async{
    app.database?.todoDao.create(data);
    getTodoList();

  }

  deleteTodoList(Todo data) async{
    app.database?.todoDao.deleteById(data.id ?? 0);
    getTodoList();

  }

  updateTodoList(Todo data) async{
    data.done = !data.done;
    app.database?.todoDao.update(data);
    getTodoList();
    setState(() {
    });
  }

  @override
  void initState() {
    super.initState();
    getTodoList();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        showCreateTodoDialog();
      },child: Icon(Icons.add),),
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              _buildSearchBar(),
              SizedBox(height: 20,),
              _buildToDoList()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar(){
    return TextField(
      onChanged: searchTodo,
      decoration: InputDecoration(
        hintText: "Cari todo",
        border: OutlineInputBorder()
      ),

    );
  }

  Widget _buildToDoList(){
    return ListView.builder(itemBuilder: (context,index){
      return TodoItem(data: listTodo[index], onDelete: deleteTodoList, onUpdate: updateTodoList);
    },itemCount: listTodo.length,shrinkWrap: true,physics: NeverScrollableScrollPhysics(),);
  }
}
