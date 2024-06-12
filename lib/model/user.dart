import 'package:sqflite_demo/core/constants.dart';

class User {
  int? id;
  String name;
  int age;

  User({this.id, required this.name, required this.age});

  Map<String, dynamic> toJson() => {
        UsersTableColumn.name: name,
        UsersTableColumn.age: age,
      };

  factory User.fromJson(Map<String, dynamic> map) => User(
      id: map[UsersTableColumn.id] ?? -1,
      name: map[UsersTableColumn.name] ?? '',
      age: map[UsersTableColumn.age] ?? -1);

  User copyWith(
    final int? id,
    final String? name,
    final int? age,
  ) =>
      User(id: id ?? this.id, name: name ?? this.name, age: age ?? this.age);
}
