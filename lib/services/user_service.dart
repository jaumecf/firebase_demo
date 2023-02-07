import 'dart:convert';
import '../models/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserService extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final String _baseUrl =
      "fir-demo-acecf-default-rtdb.europe-west1.firebasedatabase.app";
  List<User> users = [];
  late User tempUser;
  User? newUser;

  UserService() {
    this.loadUsers();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  updateVerification(bool value) {
    this.tempUser.verificat = value;
    notifyListeners();
  }

  loadUsers() async {
    users.clear();
    final url = Uri.https(_baseUrl, 'users.json');
    final response = await http.get(url);
    final Map<String, dynamic> usersMap = json.decode(response.body);

    // Mapejam la resposta del servidor, per cada usuari, el convertim a la classe i l'afegim a la llista
    usersMap.forEach((key, value) {
      final auxUser = User.fromMap(value);
      auxUser.id = key;
      users.add(auxUser);
    });

    notifyListeners();
  }

  Future saveOrCreateUser() async {
    if (tempUser.id == null) {
      //Cream l'usuari
      await this.createUser();
    } else {
      //Actualitzam l'usuari
      await this.updateUser();
    }
    loadUsers();
  }

  updateUser() async {
    final url = Uri.https(_baseUrl, 'users/${tempUser.id}.json');
    final response = await http.put(url, body: tempUser.toJson());
    final decodedData = response.body;
  }

  createUser() async {
    final url = Uri.https(_baseUrl, 'users.json');
    final response = await http.post(url, body: tempUser.toJson());
    final decodedData = json.decode(response.body);
  }

  deleteUser(User usuari) async {
    final url = Uri.https(_baseUrl, 'users/${usuari.id}.json');
    final response = await http.delete(url);
    final decodedData = json.decode(response.body);
    print(decodedData);
    loadUsers();
  }
}
