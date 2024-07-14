import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'domain.dart';

part 'repository.g.dart';

class TaskPreferences {
  Future<List<Task>> findAllTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksStringList = prefs.getStringList('tasks') ?? [];
    var taskList = tasksStringList.map((e) => Task.fromJsonString(e)).toList();
    mergeSort(taskList, compare: (a, b) {
      if (a.completed == b.completed) {
        return 0;
      } else {
        return a.completed ? 1 : -1;
      }
    });
    return taskList;
  }

  Future<void> insertTask(Task task) async {
    final taskList = await findAllTasks();
    if (taskList.any((t) => t.description == task.description)) {
      throw TaskException('Task already exists');
    }
    final prefs = await SharedPreferences.getInstance();
    final tasksString = prefs.getStringList('tasks') ?? [];
    tasksString.add(json.encode(task.toJson()));
    prefs.setStringList('tasks', tasksString);
  }

  Future<void> deleteTask(Task task) async {
    final prefs = await SharedPreferences.getInstance();
    final tasksString = prefs.getStringList('tasks') ?? [];
    tasksString.removeWhere((t) => Task.fromJsonString(t) == task);
    prefs.setStringList('tasks', tasksString);
  }

  Future<void> updateTask(Task oldTask, Task newTask) async {
    final prefs = await SharedPreferences.getInstance();
    final tasksString = prefs.getStringList('tasks') ?? [];
    final index =
        tasksString.indexWhere((t) => Task.fromJsonString(t) == oldTask);
    if (index != -1) {
      tasksString[index] = json.encode(newTask.toJson());
      prefs.setStringList('tasks', tasksString);
    }
  }
}

@Riverpod(keepAlive: true)
TaskPreferences taskPreferences(TaskPreferencesRef ref) {
  return TaskPreferences();
}
