// database.dart

// required package imports
import 'dart:async';

import 'package:floor/floor.dart';
import 'domain.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'repository.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Task])
abstract class AppDatabase extends FloorDatabase {
  TaskDao get taskDao;
}
