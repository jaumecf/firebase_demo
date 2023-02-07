import 'dart:convert';
import '../models/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserService extends ChangeNotifier {
  final String _baseUrl =
      "fir-demo-acecf-default-rtdb.europe-west1.firebasedatabase.app";
  final List<User> users = [];
  late User tempUser;

  UserService() {
    this.loadUsers();
  }

  updateVerification(bool value) {
    this.tempUser.verificat = value;
    notifyListeners();
  }

  loadUsers() async {
    final url = Uri.https(_baseUrl, 'users.json');
    final response = await http.get(url);

    final Map<String, dynamic> usersMap = json.decode(response.body);

    // Mapejam la resposta del servidor, per cada usuari, el convertim a la classe i l'afegim a la llista
    usersMap.forEach((key, value) {
      final tempUser = User.fromMap(value);
      tempUser.id = key;
      users.add(tempUser);
    });

    notifyListeners();
  }
}
