import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_demo/core/constants.dart';
import 'package:sqflite_demo/core/user_database_helper.dart';
import 'package:sqflite_demo/model/user.dart';

void main() {
  group('UsreDatabaseHelper class tests', () {
    late UserDatabaseHelper userDatabaseHelper;
    setUpAll(() async {
      sqfliteFfiInit();
      Database db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
      await db.execute(DatabaseQuery.createUsersTable);
      userDatabaseHelper = UserDatabaseHelper(db);
    });

    test('first user information should be inserted', () async {
      User user = User(name: 'Ali', age: 30);

      User insertedUser = await userDatabaseHelper.insertUser(user);

      expect(insertedUser.id, 1);
    });

    test('first user information should be fetched/read', () async {
      int id = 1;

      User user = await userDatabaseHelper.getUser(id);

      expect(user.name, 'Ali');
    });

    test('first user information should be updated', () async {
      User user = User(id: 1, name: 'Zain', age: 30);
      bool updated = await userDatabaseHelper.updateUser(user);
      expect(updated, true);
    });

    test('first user information should be deleted', () async {
      int id = 1;

      bool deleted = await userDatabaseHelper.deleteUser(id);

      expect(deleted, true);
    });

    test('first user information should be deleted', () async {
      User user1 = User(name: 'Ali', age: 30);
      User user2 = User(name: 'Adam', age: 40);
      User user3 = User(name: 'Zain', age: 34);
      await userDatabaseHelper.insertUser(user1);
      await userDatabaseHelper.insertUser(user2);
      await userDatabaseHelper.insertUser(user2);

      List<User> users = await userDatabaseHelper.getUsers();

      expect(users.length, 3);
    });
  });
}
