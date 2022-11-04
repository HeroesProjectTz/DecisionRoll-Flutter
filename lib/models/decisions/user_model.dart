import 'dart:convert';

class UserModel {
  String uid;
  String name;
  UserModel({
    required this.uid,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
