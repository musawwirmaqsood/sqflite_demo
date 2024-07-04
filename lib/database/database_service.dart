import 'package:local_database_demo/core/constants.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  Future<Database> init() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'users_demo.db');

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(DatabaseQuery.createUsersTable);
    });
  }
}
