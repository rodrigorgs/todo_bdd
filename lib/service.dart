import 'repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'domain.dart';

part 'service.g.dart';

class TaskListService {
  final TaskPreferences taskDao;

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
    final newTask = task.copyWith(
        description: description ?? task.description,
        completed: completed ?? task.completed);
    taskDao.updateTask(task, newTask);
  }
}

@Riverpod(keepAlive: true)
TaskListService taskListService(TaskListServiceRef ref) {
  final prefs = ref.watch(taskPreferencesProvider);
  return TaskListService(taskDao: prefs);
}
