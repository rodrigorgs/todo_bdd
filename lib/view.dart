import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'controller.dart';
import 'domain.dart';

class MainPage extends ConsumerWidget {
  const MainPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: const TaskListWidget(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showCreateTaskDialog(context, ref);
          },
          child: const Icon(Icons.add),
        ));
  }

  void _showCreateTaskDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) {
        String newTaskDescription = '';

        return AlertDialog(
          title: const Text('Create Task'),
          content: TextField(
            onChanged: (value) {
              newTaskDescription = value;
            },
            decoration: const InputDecoration(
              labelText: 'Task Description',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (newTaskDescription.isNotEmpty) {
                  ref
                      .read(taskListControllerProvider.notifier)
                      .addTask(Task(newTaskDescription));
                  // setState(() {
                  //   tasks.add(TodoTask(
                  //     description: newTaskDescription,
                  //     completed: false,
                  //   ));
                  // });
                  Navigator.pop(context);
                }
              },
              child: const Text('Create'),
            ),
          ],
        );
      },
    );
  }
}

class TaskListWidget extends ConsumerWidget {
  const TaskListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskList = ref.watch(taskListControllerProvider);
    return taskList.when(
      data: (l) => l.isEmpty
          ? const Center(
              child: Text('No tasks found'),
            )
          : ListView.builder(
              itemCount: l.length,
              itemBuilder: (context, index) {
                return _createTaskView(l, index, ref, context);
              },
            ),
      error: (o, s) => Text('Error: $o'),
      loading: () => const CircularProgressIndicator(),
    );
  }

  ListTile _createTaskView(
      List<Task> l, int index, WidgetRef ref, BuildContext context) {
    return ListTile(
        title: Text(l[index].description),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
                value: l[index].completed,
                onChanged: (value) {
                  ref
                      .read(taskListControllerProvider.notifier)
                      .editTask(l[index], completed: value!);
                }),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                ref
                    .read(taskListControllerProvider.notifier)
                    .removeTask(l[index]);
              },
            ),
            IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  _showEditTaskDialog(context, ref, l[index]);
                }),
          ],
        ));
  }

  void _showEditTaskDialog(BuildContext context, WidgetRef ref, Task task) {
    showDialog(
      context: context,
      builder: (context) {
        String newDescription = '';

        return AlertDialog(
          title: const Text('Edit Task'),
          content: TextFormField(
            initialValue: task.description,
            onChanged: (value) {
              newDescription = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                ref
                    .read(taskListControllerProvider.notifier)
                    .editTask(task, description: newDescription);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
