import 'package:get_it/get_it.dart';
import 'package:sqflite_demo/core/database_service.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<DatabaseService>(DatabaseService());
}
