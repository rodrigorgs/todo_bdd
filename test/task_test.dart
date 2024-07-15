// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './step/the_app_is_running.dart';
import './step/i_see_text.dart';
import './step/i_add_a_task.dart';
import './step/i_mark_the_task_as.dart';
import './step/i_see_the_tasks_in_order.dart';
import './step/the_task_is.dart';
import './step/i_see_text_exactly_times.dart';
import './step/i_change_the_task_to.dart';
import './step/i_delete_the_task.dart';
import './step/i_dont_see_text.dart';

void main() {
  group('''List tasks''', () {
    testWidgets('''Empty list''', (tester) async {
      await theAppIsRunning(tester);
      await iSeeText(tester, "No tasks found");
    });
    testWidgets('''Completed tasks go to the bottom''', (tester) async {
      await theAppIsRunning(tester);
      await iAddATask(tester, "First");
      await iAddATask(tester, "Second");
      await iMarkTheTaskAs(tester, "First", 'completed');
      await iSeeTheTasksInOrder(tester, ["Second", "First"]);
    });
  });
  group('''Add task''', () {
    testWidgets('''Add a task''', (tester) async {
      await theAppIsRunning(tester);
      await iAddATask(tester, "Buy milk");
      await iSeeText(tester, "Buy milk");
      await theTaskIs(tester, "Buy milk", 'pending');
    });
    testWidgets('''Add a duplicate task''', (tester) async {
      await theAppIsRunning(tester);
      await iAddATask(tester, "Buy milk");
      await iAddATask(tester, "Buy milk");
      await iSeeTextExactlyTimes(tester, "Buy milk", 1);
    });
  });
  group('''Edit task''', () {
    testWidgets('''Mark a task as completed''', (tester) async {
      await theAppIsRunning(tester);
      await iAddATask(tester, "Buy milk");
      await iMarkTheTaskAs(tester, "Buy milk", 'completed');
      await theTaskIs(tester, "Buy milk", 'completed');
    });
    testWidgets('''Mark a task as pending''', (tester) async {
      await theAppIsRunning(tester);
      await iAddATask(tester, "Buy milk");
      await iMarkTheTaskAs(tester, "Buy milk", 'completed');
      await iMarkTheTaskAs(tester, "Buy milk", 'pending');
      await theTaskIs(tester, "Buy milk", 'pending');
    });
    testWidgets('''Change task description''', (tester) async {
      await theAppIsRunning(tester);
      await iAddATask(tester, "aaa");
      await iAddATask(tester, "Buy milk");
      await iAddATask(tester, "bbb");
      await iChangeTheTaskTo(tester, "Buy milk", "Buy milk and eggs");
      await iSeeText(tester, "Buy milk and eggs");
    });
  });
  group('''Delete task''', () {
    testWidgets('''Delete a task''', (tester) async {
      await theAppIsRunning(tester);
      await iAddATask(tester, "Workout");
      await iAddATask(tester, "Buy milk");
      await iAddATask(tester, "Sleep");
      await iDeleteTheTask(tester, "Buy milk");
      await iDontSeeText(tester, "Buy milk");
    });
  });
}
