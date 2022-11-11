import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decisionroll/models/database/candidate_model.dart';

import '../../common/candidate_colors.dart';

class CandidateCtrl {
  final String id;
  final String decisionId;
  final String title;
  final int index;

  const CandidateCtrl(
      {required this.id,
      required this.decisionId,
      required this.title,
      this.index = 0});

  factory CandidateCtrl.blank() {
    return const CandidateCtrl(
        id: '<missing id',
        decisionId: '<unknown decision id>',
        title: '<missing title>',
        index: CandidateColors.overflowIndex);
  }

  factory CandidateCtrl.fromModelSnapshot(
      DocumentSnapshot<CandidateModel> snapshot) {
    final model = snapshot.data() ?? CandidateModel.blank();
    final decisionId =
        snapshot.reference.parent.parent?.id ?? "decision-parent-missing";
    return CandidateCtrl(
        id: snapshot.id,
        decisionId: decisionId,
        title: model.title,
        index: model.index);
  }

  Map<String, dynamic> toMap() {
    return {'title': title, 'index': index};
  }

  String toJson() {
    return toMap().toString();
  }
}
