import 'package:flutter_test/flutter_test.dart';

import 'i_mark_the_task_as.dart';

/// Usage: the task {"Buy milk"} is {'completed'}
Future<void> theTaskIs(
    WidgetTester tester, String param1, String param2) async {
  final checkbox = findCheckboxForTask(param1, tester);
  // expect the checkbox to be enabled
  expect(checkbox.value, param2 == 'completed');
}
