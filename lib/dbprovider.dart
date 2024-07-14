import 'database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dbprovider.g.dart';

@Riverpod(keepAlive: true)
Future<AppDatabase> db(ref) async {
  throw UnimplementedError();
}
