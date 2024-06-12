import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_demo/core/constants.dart';
import 'package:sqflite_demo/model/user.dart';

class DatabaseService {
  late Database database;

  Future<void> init() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'users_demo.db');
    database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(DatabaseQuery.createUsersTable);
    });
  }

  Future<User> insertUser(User user) async {
    user.id = await database.insert(DatabaseTable.users, user.toJson());
    return user;
  }

  Future<User> getUser(int id) async {
    final queryResponse =
        await database.rawQuery(DatabaseQuery.fetchUserById(id));
    return User.fromJson(queryResponse.first);
  }

  Future<bool> updateUser(User user) async {
    int success = await database.update(DatabaseTable.users, user.toJson(),
        where: 'id =?', whereArgs: [user.id]);
    return success == 1;
  }

  Future<bool> deleteUser(int id) async {
    int deleted = await database
        .delete(DatabaseTable.users, where: 'id =?', whereArgs: [id]);
    return deleted == 1;
  }

  Future<List<User>> getUsers() async {
    final queryResponse = await database.rawQuery(DatabaseQuery.fetchUsers);
    return queryResponse.map(User.fromJson).toList();
  }
}
