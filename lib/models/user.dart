import 'dart:convert';

class User {
  User({
    this.id,
    required this.edat,
    required this.nom,
    required this.verificat,
  });
  String? id;
  int edat;
  String nom;
  bool verificat;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        edat: json["edat"],
        nom: json["nom"],
        verificat: json["verificat"],
      );

  Map<String, dynamic> toMap() => {
        "edat": edat,
        "nom": nom,
        "verificat": verificat,
      };

  User copy() => User(edat: edat, nom: nom, verificat: verificat);
}
