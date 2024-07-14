import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myfloor/database.dart';
import 'package:myfloor/dbprovider.dart';
import 'package:myfloor/main.dart';

Future<void> theAppIsRunning(WidgetTester tester) async {
  final db = await $FloorAppDatabase.inMemoryDatabaseBuilder().build();
  // final db = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  await tester.pumpWidget(
    ProviderScope(
      overrides: [dbProvider.overrideWith((ref) => db)],
      child: const MainApp(),
    ),
  );
  await tester.pumpAndSettle();
}
