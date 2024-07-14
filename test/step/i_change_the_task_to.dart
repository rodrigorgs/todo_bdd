import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers.dart';
import 'i_tap_text.dart';

/// Usage: I change the task {"Buy milk"} to {"Buy milk and eggs"}
Future<void> iChangeTheTaskTo(
    WidgetTester tester, String taskDescription, String newDescription) async {
  final finder = findTileForTask(taskDescription);
  final icon = find.descendant(
    of: finder,
    matching: find.byIcon(Icons.edit),
  );
  await tester.tap(icon);
  await tester.pumpAndSettle();
  await tester.enterText(find.byType(TextField), newDescription);
  await iTapText(tester, 'Save');
  await tester.pumpAndSettle();
}
