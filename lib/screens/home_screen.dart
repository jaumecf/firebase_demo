import 'package:firebase_demo/services/services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import '../ui/ui.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: userService.users.isEmpty
          ? Loading()
          : ListView.builder(
              itemCount: userService.users.length,
              itemBuilder: ((context, index) {
                return GestureDetector(
                  child: UserCard(usuari: userService.users[index]),
                  onTap: () {
                    userService.tempUser = userService.users[index].copy();
                    Navigator.of(context).pushNamed('detail');
                  },
                );
              }),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => print('Obre nou'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
