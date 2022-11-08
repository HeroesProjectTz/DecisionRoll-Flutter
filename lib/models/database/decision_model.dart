import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class DecisionModel {
  String id;
  String ownerId;
  String title;
  String outcome;
  String state;

  DecisionModel({
    required this.id,
    required this.ownerId,
    required this.title,
    required this.outcome,
    required this.state,
  });

  Map<String, dynamic> toMap() {
    return {
      'ownerId': ownerId,
      'title': title,
      'outcome': outcome,
      'state': state,
    };
  }

  factory DecisionModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final map = snapshot.data() ?? {};
    map['id'] = snapshot.id;
    return DecisionModel.fromMap(map);
  }

  factory DecisionModel.fromMap(Map<String, dynamic> map) {
    return DecisionModel(
        id: map['id'] ?? '',
        ownerId: map['ownerId'] ?? '',
        title: map['title'] ?? '',
        outcome: map['outcome'] ?? '',
        state: map['state'] ?? '');
  }

  String toJson() {
    return toMap().toString();
  }

  factory DecisionModel.fromJson(String source) =>
      DecisionModel.fromMap(json.decode(source));
}
