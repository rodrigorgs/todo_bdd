// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_import, directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import './step/the_app_is_running.dart';
import './step/i_see_text.dart';
import './step/i_add_a_task.dart';

void main() {
  group('''List tasks''', () {
    testWidgets('''Empty list''', (tester) async {
      await theAppIsRunning(tester);
      await iSeeText(tester, "No tasks found");
    });
  });
  group('''Add task''', () {
    testWidgets('''Add a task''', (tester) async {
      await theAppIsRunning(tester);
      await iAddATask(tester, "Buy milk");
      await iSeeText(tester, "Buy milk");
    });
  });
}
