import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decisionroll/models/database/candidate_model.dart';
import 'dart:math';

class DecisionModel {
  final String ownerId;
  final String title;
  final String? outcome;
  final String state;

  const DecisionModel(
      {required this.ownerId,
      required this.title,
      this.outcome,
      this.state = 'new'});

  factory DecisionModel.blank() {
    return const DecisionModel(
        ownerId: "<missing owner>", title: '<missing title>');
  }

  String nextState() {
    switch (state) {
      case 'new':
        return 'open';
      case 'open':
        return 'closed';
      case 'closed':
        return 'finished';
      case 'finished':
        return 'open';
      default:
        return 'closed';
    }
  }

  // TODO pass in candidates list to calculate outcome
  DecisionModel advanceState(
      List<DocumentSnapshot<CandidateModel>> candidates) {
    return DecisionModel(
        ownerId: ownerId,
        title: title,
        state: nextState(),
        outcome: _newOutcome(candidates));
  }

  String? _newOutcome(List<DocumentSnapshot<CandidateModel>> candidates) {
    switch (nextState()) {
      case 'finished':
        return _calcOutcome(candidates);
      default:
        return null;
    }
  }

  String _calcOutcome(List<DocumentSnapshot<CandidateModel>> candidates) {
    final int totalWeight = candidates.fold(
        0,
        (previousValue, element) =>
            previousValue + (element.data()?.weight ?? 0));
    final int roll = Random().nextInt(totalWeight);
    int runningTotal = 0;
    for (final candidate in candidates) {
      final candidateModel = candidate.data();
      if (candidateModel != null) {
        runningTotal += candidate.data()?.weight ?? 0;
        if (roll < runningTotal) return candidateModel.title;
      }
    }
    return "<unexpected data>";
  }

  factory DecisionModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final map = snapshot.data() ?? {};

    return DecisionModel(
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
