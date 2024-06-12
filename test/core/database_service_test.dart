import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_demo/core/constants.dart';
import 'package:sqflite_demo/model/user.dart';

void main() {
  group('database service tests', () {
    late Database db;
    setUpAll(() async {
      sqfliteFfiInit();
      db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    });

    test('users table should be created', () async {
      await db.execute(DatabaseQuery.createUsersTable);
      var tables = await db.rawQuery(
          'SELECT * FROM sqlite_master WHERE name= "${DatabaseTable.users}"');
      expect(tables.first['name'], DatabaseTable.users);
    });

    test('first user information should be inserted', () async {
      int id = await db.insert(
          DatabaseTable.users, User(name: 'Ali', age: 30).toJson());
      expect(id, 1);
    });

    test('first user information should be fetched/read', () async {
      int id = 1;
      final queryResponse = await db.rawQuery(DatabaseQuery.fetchUserById(id));
      expect(User.fromJson(queryResponse.first).name, 'Ali');
    });

    test('first user information should be updated', () async {
      int success = await db.update(
          DatabaseTable.users, User(name: 'Zain', age: 34).toJson(),
          where: 'id =?', whereArgs: [1]);
      expect(success, 1);

      final queryResponse = await db.rawQuery(DatabaseQuery.fetchUserById(1));
      expect(User.fromJson(queryResponse.first).name, 'Zain');
    });

    test('first user information should be deleted', () async {
      int deleted =
          await db.delete(DatabaseTable.users, where: 'id =?', whereArgs: [1]);
      expect(deleted, 1);
      final queryResponse = await db.rawQuery(DatabaseQuery.fetchUserById(1));
      expect(queryResponse.length, 0);
    });

    test('3 user\'s information should be inserted', () async {
      User user1 = User(name: 'Ali', age: 30);
      User user2 = User(name: 'Adam', age: 40);
      User user3 = User(name: 'Zain', age: 34);
      await db.transaction((txn) async {
        await txn.insert(DatabaseTable.users, user1.toJson());
        await txn.insert(DatabaseTable.users, user2.toJson());
        await txn.insert(DatabaseTable.users, user3.toJson());
      });

      final queryResponse = await db.rawQuery(DatabaseQuery.fetchUsers);
      List<User> users = queryResponse.map(User.fromJson).toList();
      expect(users.length, 3);
      expect(users.first.name, 'Ali');
    });
  });
}
