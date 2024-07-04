import 'package:flutter/material.dart';
import 'package:local_database_demo/core/di.dart';
import 'package:local_database_demo/database/user_database_helper.dart';
import 'package:local_database_demo/models/user.dart';
import 'package:local_database_demo/views/add_update_user_page.dart';

class UserListViewPage extends StatefulWidget {
  const UserListViewPage({
    super.key,
  });

  @override
  State<UserListViewPage> createState() => _UserListViewPageState();
}

class _UserListViewPageState extends State<UserListViewPage> {
  final UserDatabaseHelper userDatabaseHelper = getIt<UserDatabaseHelper>();
  List<User> userList = [];

  void _getUserList() async {
    userList = await userDatabaseHelper.getUsers();
    setState(() {});
  }

  void _deleteUser(int id) async {
    await userDatabaseHelper.deleteUser(id);
    _getUserList();
  }

  @override
  void initState() {
    super.initState();
    _getUserList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('User App'),
      ),
      body: userList.isEmpty
          ? const Center(child: Text('User list is empty'))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.separated(
                itemCount: userList.length,
                itemBuilder: (context, index) => ListTile(
                  onTap: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddUpdateUserPage(
                                  user: userList[index],
                                )));
                    _getUserList();
                  },
                  tileColor: Theme.of(context).colorScheme.primaryContainer,
                  title: Text(userList[index].name),
                  subtitle: Text('Age: ${userList[index].age}'),
                  trailing: IconButton(
                      onPressed: () {
                        _deleteUser(userList[index].id!);
                      },
                      icon: const Icon(Icons.delete)),
                ),
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 8,
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddUpdateUserPage()));
          _getUserList();
        },
        tooltip: 'add',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
