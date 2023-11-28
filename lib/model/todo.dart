

import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'todo.g.dart';



@JsonSerializable()
@Entity()
class Todo{
  @PrimaryKey()
  int? id;
  String title;
  String description;
  bool done;

  Todo({required this.id,required this.title,required this.description,required this.done});

  factory Todo.fromJson(Map<String,dynamic> json) => _$TodoFromJson(json);

  Map<String,dynamic> toJson() => _$TodoToJson(this);
}