import 'package:myfloor/dbprovider.dart';
import 'package:myfloor/repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'domain.dart';

part 'service.g.dart';

class TaskListService {
  final TaskDao taskDao;

  TaskListService({required this.taskDao});

  Future<List<Task>> get tasks {
    return taskDao.findAllTasks();
  }

  Future<void> addTask(Task task) async {
    taskDao.insertTask(task);
  }

  Future<void> removeTask(Task task) async {
    taskDao.deleteTask(task);
  }

  void editTask(Task task, {String? description, bool? completed}) {
    final newTask = Task(description ?? task.description,
        completed: completed ?? task.completed, id: task.id);
    taskDao.updateTask(newTask);
  }
}

@Riverpod(keepAlive: true)
TaskListService taskListService(TaskListServiceRef ref) {
  final db = ref.watch(dbProvider).value!;
  return TaskListService(taskDao: db.taskDao);
}

// final taskListServiceProvider = Provider((ref) => TaskListService());
