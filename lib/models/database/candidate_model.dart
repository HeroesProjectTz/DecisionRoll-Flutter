import 'package:cloud_firestore/cloud_firestore.dart';

class CandidateModel {
  final DocumentSnapshot? snapshot;
  final String? id;
  final String title;
  final int weight;

  const CandidateModel(
      {this.snapshot, this.id, required this.title, this.weight = 0});

  factory CandidateModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final map = snapshot.data() ?? {};

    return CandidateModel(
        snapshot: snapshot,
        id: snapshot.id,
        title: map['title'] ?? '<missing title>',
        weight: map['weight'] ?? 0);
  }
  Map<String, dynamic> toMap() {
    return {'title': title, 'weight': weight};
  }

  String toJson() {
    return toMap().toString();
  }
}
