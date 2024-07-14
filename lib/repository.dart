// dao/Task_dao.dart

import 'package:floor/floor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'domain.dart';

@dao
abstract class TaskDao {
  @Query('SELECT * FROM Task')
  Future<List<Task>> findAllTasks();

  @Query('SELECT name FROM Task')
  Stream<List<String>> findAllTasksName();

  @Query('SELECT * FROM Task WHERE id = :id')
  Stream<Task?> findTaskById(int id);

  @insert
  Future<void> insertTask(Task task);

  @delete
  Future<void> deleteTask(Task task);

  @update
  Future<void> updateTask(Task task);
}

// class TaskPreferences {
//   Future<List<Task>> findAllTasks() async {
//     final prefs = await SharedPreferences.getInstance();
//     final tasksString = prefs.getStringList('tasks') ?? [];
//     return tasksString.map((e) => Task.fromJson(e)).toList();
//   }

//   @Query('SELECT name FROM Task')
//   Stream<List<String>> findAllTasksName() {}

//   @Query('SELECT * FROM Task WHERE id = :id')
//   Stream<Task?> findTaskById(int id) {}

//   @insert
//   Future<void> insertTask(Task task) {}

//   @delete
//   Future<void> deleteTask(Task task) {}

//   @update
//   Future<void> updateTask(Task task) {}
// }
