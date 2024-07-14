import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: I mark the task {"Buy milk"} as {'completed'}
Future<void> iMarkTheTaskAs(
    WidgetTester tester, String taskDescription, String param2) async {
  Checkbox checkbox = findCheckboxForTask(taskDescription, tester);
  checkbox.onChanged!(param2 == 'completed');
  await tester.pump();

  checkbox = findCheckboxForTask(taskDescription, tester);
  expect(checkbox.value, (param2 == 'completed'));
}

Checkbox findCheckboxForTask(String taskDescription, WidgetTester tester) {
  Finder listTileFinder = find.byElementPredicate(
    (element) =>
        element.widget is ListTile && (element.widget as ListTile).title is Text
            ? (element.widget as ListTile)
                .title
                .toString()
                .contains(taskDescription)
            : false,
  );

  Finder checkboxFinder = find.descendant(
    of: listTileFinder,
    matching: find.byType(Checkbox),
  );

  final checkbox = tester.widget<Checkbox>(checkboxFinder);
  return checkbox;
}
