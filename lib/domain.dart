import 'package:floor/floor.dart';

@entity
class Task {
  @primaryKey
  int? id;

  String description;
  bool completed;

  Task(this.description, {this.completed = false, this.id});
}
