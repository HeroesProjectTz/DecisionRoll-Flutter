import 'package:cloud_firestore/cloud_firestore.dart';

class CandidateModel {
  final DocumentSnapshot snapshot;
  final String id;
  final String name;
  final int weight;

  const CandidateModel(
      {required this.snapshot,
      required this.id,
      required this.name,
      required this.weight});

  factory CandidateModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final map = snapshot.data() ?? {};

    return CandidateModel(
        snapshot: snapshot,
        id: snapshot.id,
        name: map['name'] ?? '<missing name>',
        weight: map['weight'] ?? 0);
  }
  Map<String, dynamic> toMap() {
    return {'name': name, 'weight': weight};
  }

  String toJson() {
    return toMap().toString();
  }
}
