import 'package:cloud_firestore/cloud_firestore.dart';

class CandidateModel {
  final String title;
  final int weight;
  final int colorIdx;

  const CandidateModel(
      {required this.title, this.weight = 0, this.colorIdx = 0});

  factory CandidateModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final map = snapshot.data() ?? {};
    return CandidateModel.fromMap(map);
  }

  factory CandidateModel.fromMap(Map<String, dynamic> map) => CandidateModel(
      title: map['title'] ?? '<missing title>',
      weight: map['weight'],
      colorIdx: map['colorIdx']);

  Map<String, dynamic> toMap() {
    return {'title': title, 'weight': weight, 'colorIdx': colorIdx};
  }

  String toJson() {
    return toMap().toString();
  }
}
