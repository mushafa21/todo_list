

import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:to_do_list/dao/todo_dao.dart';
import 'package:to_do_list/model/todo.dart';

part 'todo_database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Todo])
abstract class TodoDatabase extends FloorDatabase {
  TodoDao get todoDao;
}