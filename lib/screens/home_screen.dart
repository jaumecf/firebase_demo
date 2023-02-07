import 'package:firebase_demo/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context);
    if (userService.users.isEmpty) {
      return CircularProgressIndicator();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: ListView.builder(
        itemCount: userService.users.length,
        itemBuilder: ((context, index) {
          return GestureDetector(
            child: UserCard(usuari: userService.users[index]),
            onTap: () => print('TDODO: Obrir detall user'),
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
