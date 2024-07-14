import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myfloor/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> theAppIsRunning(WidgetTester tester) async {
  SharedPreferences.setMockInitialValues({});
  await tester.pumpWidget(
    const ProviderScope(
      child: MainApp(),
    ),
  );
  await tester.pumpAndSettle();
}
