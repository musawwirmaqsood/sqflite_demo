import 'package:flutter/material.dart';
import 'package:sqflite_demo/core/di.dart';
import 'package:sqflite_demo/core/user_database_helper.dart';
import 'package:sqflite_demo/model/user.dart';

class AddUpdateUserPage extends StatefulWidget {
  final User? user;
  const AddUpdateUserPage({this.user, super.key});

  @override
  State<AddUpdateUserPage> createState() => _AddUpdateUserPageState();
}

class _AddUpdateUserPageState extends State<AddUpdateUserPage> {
  final UserDatabaseHelper userDatabaseHelper = getIt<UserDatabaseHelper>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  Future<User?> _addUser() async {
    if (nameController.text.isEmpty || ageController.text.isEmpty) return null;
    return await userDatabaseHelper.insertUser(
        User(name: nameController.text, age: int.parse(ageController.text)));
  }

  Future<bool> _updateUser() async {
    if (nameController.text.isEmpty || ageController.text.isEmpty) return false;
    return await userDatabaseHelper.updateUser(User(
        id: user!.id,
        name: nameController.text,
        age: int.parse(ageController.text)));
  }

  User? get user => widget.user;

  @override
  void initState() {
    super.initState();
    if (user != null) {
      nameController.text = user!.name;
      ageController.text = user!.age.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(user == null ? ' Add User' : 'Update User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Name',
                  hintText: 'Enter Your Name'),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Age',
                  hintText: 'Enter Your Age'),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
                onPressed: user == null
                    ? () async {
                        if (await _addUser() != null) {
                          if (context.mounted) Navigator.pop(context);
                        }
                      }
                    : () async {
                        if (await _updateUser()) {
                          if (context.mounted) Navigator.pop(context);
                        }
                      },
                child: Text(user == null ? 'Add' : 'Update'))
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
