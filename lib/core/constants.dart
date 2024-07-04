class UsersTable {
  static const String tableName = 'users';

  static const String id = 'id';
  static const String name = 'name';
  static const String age = 'age';
}

class DatabaseQuery {
  static const String createUsersTable = '''
            create table ${UsersTable.tableName}(
            ${UsersTable.id} INTEGER PRIMARY KEY AUTOINCREMENT,
            ${UsersTable.name} TEXT NOT NULL,
            ${UsersTable.age} INTEGER NOT NULL
          )
          ''';

  static String fetchUsers = 'select * from ${UsersTable.tableName}';

  static String fetchUserById(int id) =>
      'select * from ${UsersTable.tableName} where ${UsersTable.id} == $id';
}
