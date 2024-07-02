import 'package:get_it/get_it.dart';
import 'package:sqflite_demo/core/database_service.dart';
import 'package:sqflite_demo/core/user_database_helper.dart';

final getIt = GetIt.instance;

void setup() async {
  getIt.registerSingleton<UserDatabaseHelper>(
      UserDatabaseHelper(await DatabaseService().init()));
}
