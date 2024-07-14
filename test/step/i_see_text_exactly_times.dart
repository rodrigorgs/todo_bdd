import 'package:flutter_test/flutter_test.dart';

/// Usage: I see {"Buy milk"} text exactly {1} times
Future<void> iSeeTextExactlyTimes(
    WidgetTester tester, String text, int count) async {
  expect(find.text(text, skipOffstage: false), findsNWidgets(count));
}
