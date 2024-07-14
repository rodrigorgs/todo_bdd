import 'package:flutter_test/flutter_test.dart';

import 'i_tap_text.dart';

/// Usage: I delete the task {"Buy milk"}
Future<void> iDeleteTheTask(WidgetTester tester, String taskDescription) async {
  await iTapText(tester, taskDescription);
  await iTapText(tester, 'Delete');
}
