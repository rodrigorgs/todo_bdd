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
            autofocus: true,
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
              onPressed: () async {
                if (newTaskDescription.isNotEmpty) {
                  bool result = await ref
                      .read(taskListControllerProvider.notifier)
                      .addTask(Task(newTaskDescription));
                  if (context.mounted) {
                    if (!result) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'The task was not created because it was a duplicate'),
                        ),
                      );
                    }

                    Navigator.pop(context);
                  }
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
                return TaskTile(index: index);
              },
            ),
      error: (o, s) => Text('Error: $o'),
      loading: () => const CircularProgressIndicator(),
    );
  }
}

class TaskTile extends ConsumerWidget {
  final int index;
  const TaskTile({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(taskListControllerProvider);
    if (asyncValue.hasError) {
      return const Placeholder();
    }
    final l = asyncValue.asData!.value;

    return ListTile(
        title: Text(
          l[index].description,
          style: l[index].completed
              ? TextStyle(
                  decoration: TextDecoration.lineThrough,
                  color: Colors.grey[600])
              : null,
        ),
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
                _showDeleteTaskDialog(context, ref, l[index]);
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

  void _showDeleteTaskDialog(BuildContext context, WidgetRef ref, Task task) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Task'),
          content: Text(
              'Are you sure you want to delete task "${task.description}"?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              onPressed: () {
                ref.read(taskListControllerProvider.notifier).removeTask(task);
                Navigator.pop(context);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
