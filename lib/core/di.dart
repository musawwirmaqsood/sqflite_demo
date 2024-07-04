import 'package:get_it/get_it.dart';
import 'package:local_database_demo/database/database_service.dart';
import 'package:local_database_demo/database/user_database_helper.dart';

final getIt = GetIt.instance;

Future<void> setupDI() async {
  getIt.registerSingleton<UserDatabaseHelper>(
      UserDatabaseHelper(await DatabaseService().init()));
}
