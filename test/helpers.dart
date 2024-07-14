import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget findWidgetForTask(
    String taskDescription, WidgetTester tester, Type type) {
  Finder listTileFinder = findTileForTask(taskDescription);

  Finder elementFinder = find.descendant(
    of: listTileFinder,
    matching: find.byType(type),
  );

  final element = tester.widget(elementFinder);
  return element;
}

Finder findTileForTask(String taskDescription) {
  Finder listTileFinder = find.byElementPredicate(
    (element) =>
        element.widget is ListTile && (element.widget as ListTile).title is Text
            ? (element.widget as ListTile)
                .title
                .toString()
                .contains(taskDescription)
            : false,
  );
  return listTileFinder;
}
