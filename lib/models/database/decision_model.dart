import 'package:cloud_firestore/cloud_firestore.dart';

class DecisionModel {
  final DocumentSnapshot snapshot;
  final String id;
  final String ownerId;
  final String title;
  final String? outcome;
  final String state;

  const DecisionModel({
    required this.snapshot,
    required this.id,
    required this.ownerId,
    required this.title,
    required this.outcome,
    required this.state,
  });

  factory DecisionModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final map = snapshot.data() ?? {};

    return DecisionModel(
        snapshot: snapshot,
        id: snapshot.id,
        ownerId: map['ownerId'] ?? '<missing ownerId>',
        title: map['title'] ?? '<missing title>',
        outcome: map['outcome'],
        state: map['state'] ?? 'new');
  }

  Map<String, dynamic> toMap() {
    return {
      'ownerId': ownerId,
      'title': title,
      'outcome': outcome,
      'state': state,
    };
  }

  String toJson() {
    return toMap().toString();
  }
}
