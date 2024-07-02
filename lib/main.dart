import 'package:flutter/material.dart';
import 'package:sqflite_demo/add_update_user_page.dart';
import 'package:sqflite_demo/core/database_service.dart';
import 'package:sqflite_demo/core/di.dart';
import 'package:sqflite_demo/core/user_database_helper.dart';
import 'package:sqflite_demo/model/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  await getIt<DatabaseService>().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Users'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
        title: Text(widget.title),
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
