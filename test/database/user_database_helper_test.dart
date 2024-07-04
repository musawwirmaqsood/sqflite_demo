import 'package:flutter_test/flutter_test.dart';
import 'package:local_database_demo/core/constants.dart';
import 'package:local_database_demo/database/user_database_helper.dart';
import 'package:local_database_demo/models/user.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  group('UsreDatabaseHelper class tests', () {
    late Database database;
    late UserDatabaseHelper userDatabaseHelper;

    setUpAll(() async {
      database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath,
          options: OpenDatabaseOptions(
              version: 1,
              onCreate: (Database db, int version) async {
                await db.execute(DatabaseQuery.createUsersTable);
              }));
      userDatabaseHelper = UserDatabaseHelper(database);
    });

    test('first user information should be inserted', () async {
      /// Arrange
      User user = User(name: 'Ali', age: 30);

      /// Act
      User insertedUser = await userDatabaseHelper.insertUser(user);

      ///  Assert
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

    test('getUsers should return 3 inserted users', () async {
      User user1 = User(name: 'Ali', age: 30);
      User user2 = User(name: 'Adam', age: 40);
      User user3 = User(name: 'Zain', age: 34);
      await userDatabaseHelper.insertUser(user1);
      await userDatabaseHelper.insertUser(user2);
      await userDatabaseHelper.insertUser(user3);

      List<User> users = await userDatabaseHelper.getUsers();

      expect(users.length, 3);
    });

    tearDownAll(() {
      database.close();
    });
  });
}
