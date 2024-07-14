import 'service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'domain.dart';
// import 'service.dart';

part 'controller.g.dart';

@riverpod
class TaskListController extends _$TaskListController {
  @override
  Future<List<Task>> build() async {
    return ref.read(taskListServiceProvider).tasks;
  }

  Future<void> addTask(Task task) async {
    state = const AsyncValue.loading();

    final taskService = ref.read(taskListServiceProvider);
    try {
      // state = AsyncValue.data([...state.value!, task]);
      await taskService.addTask(task);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      return;
    }

    state = AsyncValue.data(await taskService.tasks);
  }

  Future<void> removeTask(Task task) async {
    state = const AsyncValue.loading();

    final taskService = ref.read(taskListServiceProvider);

    try {
      await taskService.removeTask(task);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      return;
    }

    state = AsyncValue.data(await taskService.tasks);
  }

  Future<void> editTask(Task task,
      {String? description, bool? completed}) async {
    state = const AsyncValue.loading();

    final provider = ref.read(taskListServiceProvider);
    provider.editTask(task, description: description, completed: completed);

    state = AsyncValue.data(await provider.tasks);
  }
}
