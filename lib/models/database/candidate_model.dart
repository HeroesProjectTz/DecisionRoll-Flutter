import 'package:cloud_firestore/cloud_firestore.dart';

import '../../common/candidate_colors.dart';

class CandidateModel {
  final String title;
  final int weight;
  final int index;

  const CandidateModel({required this.title, this.weight = 0, this.index = 0});

  CandidateModel incrementWeight() {
    return CandidateModel(title: title, weight: weight + 1, index: index);
  }

  CandidateModel decrementWeight() {
    return CandidateModel(title: title, weight: weight - 1, index: index);
  }

  factory CandidateModel.blank() {
    return const CandidateModel(
        title: '<missing title>',
        weight: 0,
        index: CandidateColors.overflowIndex);
  }

  factory CandidateModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final map = snapshot.data() ?? {};
    return CandidateModel.fromMap(map);
  }

  factory CandidateModel.fromMap(Map<String, dynamic> map) => CandidateModel(
      title: map['title'] ?? '<missing title>',
      weight: map['weight'] ?? 0,
      index: map['index'] ?? 0);

  Map<String, dynamic> toMap() {
    return {'title': title, 'weight': weight, 'index': index};
  }

  String toJson() {
    return toMap().toString();
  }
}
