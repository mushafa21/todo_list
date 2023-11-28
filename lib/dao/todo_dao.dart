

import 'package:floor/floor.dart';
import 'package:to_do_list/model/todo.dart';

@dao
abstract class TodoDao{
  @insert
  Future<int> create(Todo todo);

  @Query('SELECT * FROM Todo')
  Future<List<Todo>> getAll();

  @Query('SELECT * FROM Todo WHERE title=:title')
  Future<List<Todo>> getAllByName(String title);

  @Query('DELETE FROM Todo WHERE id=:id')
  Future<void> deleteById(int id);

  @Update()
  Future<void> update(Todo todo);
}