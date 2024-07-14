import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myfloor/dbprovider.dart';
import 'package:myfloor/view.dart';

import 'database.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'view.dart';

void main() async {
  final db = await $FloorAppDatabase.databaseBuilder('app_database.db').build();

  runApp(
    ProviderScope(
      overrides: [dbProvider.overrideWith((ref) => db)],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainPage(),
    );
  }
}
