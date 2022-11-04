import 'dart:convert';

import 'package:decisionroll/models/decisions/user_model.dart';

class DecisionModel {
  UserModel owner;
  String title;
  String weight;
  DecisionModel({
    required this.title,
    required this.weight,
    required this.owner,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'weight': weight,
    };
  }

  factory DecisionModel.fromMap(Map<String, dynamic> map) {
    return DecisionModel(
        title: map['title'] ?? '',
        weight: map['weight'] ?? '',
        owner: map['owner'] ?? UserModel(name: '', uid: ''));
  }

  String toJson() => json.encode(toMap());

  factory DecisionModel.fromJson(String source) =>
      DecisionModel.fromMap(json.decode(source));
}
