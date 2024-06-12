class DatabaseTable {
  static const String users = 'Users';
}

class UsersTableColumn {
  static const String id = 'id';
  static const String name = 'name';
  static const String age = 'age';
}

class DatabaseQuery {
  static const String createUsersTable = '''
            create table ${DatabaseTable.users}(
            ${UsersTableColumn.id} INTEGER PRIMARY KEY AUTOINCREMENT,
            ${UsersTableColumn.name} TEXT NOT NULL,
            ${UsersTableColumn.age} INTEGER NOT NULL
          )
          ''';

  static String fetchUserById(int id) =>
      'select * from ${DatabaseTable.users} where ${UsersTableColumn.id} == $id';

  static String fetchUsers = 'select * from ${DatabaseTable.users}';
}
