import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Usage: I see the tasks {["Second", "First"]} in order
Future<void> iSeeTheTasksInOrder(
    WidgetTester tester, List<String> tasks) async {
  // find all ListTiles
  final listTiles = find.byType(ListTile);
  // get Text inside each list tile
  final texts = listTiles
      .evaluate()
      .map((e) => e.widget as ListTile)
      .map((e) => e.title as Text)
      .map((e) => e.data)
      .toList();
  // compare the texts with the expected order
  expect(texts, tasks);
}
