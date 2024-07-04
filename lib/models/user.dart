import 'package:local_database_demo/core/constants.dart';

class User {
  int? id;
  String name;
  int age;

  User({this.id, required this.name, required this.age});

  Map<String, dynamic> toJson() => {
        UsersTable.name: name,
        UsersTable.age: age,
      };

  factory User.fromJson(Map<String, dynamic> map) => User(
      id: map[UsersTable.id] ?? -1,
      name: map[UsersTable.name] ?? '',
      age: map[UsersTable.age] ?? -1);
}
