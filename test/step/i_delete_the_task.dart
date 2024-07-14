import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers.dart';
import 'i_tap_text.dart';

/// Usage: I delete the task {"Buy milk"}
Future<void> iDeleteTheTask(WidgetTester tester, String taskDescription) async {
  final finder = findTileForTask(taskDescription);
  final icon = find.descendant(
    of: finder,
    matching: find.byIcon(Icons.delete),
  );
  await tester.tap(icon);
  await tester.pumpAndSettle();
  await iTapText(tester, 'Delete');
}
