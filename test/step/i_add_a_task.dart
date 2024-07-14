import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'i_enter_into_input_field.dart';
import 'i_tap_icon.dart';
import 'i_tap_text.dart';

/// Usage: I add a task {"Buy milk"}
Future<void> iAddATask(WidgetTester tester, String param1) async {
  await iTapIcon(tester, Icons.add);
  await iEnterIntoInputField(tester, param1, 0);
  await iTapText(tester, 'Create');
}
