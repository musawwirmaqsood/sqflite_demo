import 'package:local_database_demo/core/constants.dart';
import 'package:local_database_demo/models/user.dart';
import 'package:sqflite/sqlite_api.dart';

class UserDatabaseHelper {
  final Database database;
  UserDatabaseHelper(this.database);

  Future<User> insertUser(User user) async {
    user.id = await database.insert(UsersTable.tableName, user.toJson());
    return user;
  }

  Future<User> getUser(int id) async {
    final List<Map<String, dynamic>> queryResponse =
        await database.rawQuery(DatabaseQuery.fetchUserById(id));
    return User.fromJson(queryResponse.first);
  }

  Future<bool> updateUser(User user) async {
    int success = await database.update(UsersTable.tableName, user.toJson(),
        where: '${UsersTable.id} =?', whereArgs: [user.id]);
    return success == 1;
  }

  Future<bool> deleteUser(int id) async {
    int deleted = await database.delete(UsersTable.tableName,
        where: '${UsersTable.id} =?', whereArgs: [id]);
    return deleted == 1;
  }

  Future<List<User>> getUsers() async {
    final queryResponse = await database.rawQuery(DatabaseQuery.fetchUsers);
    return queryResponse.map(User.fromJson).toList();
  }
}
