import 'package:decisionroll/models/database/candidate_model.dart';
import 'package:decisionroll/providers/database/database_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final decisionCandidatesProvider = StreamProvider.autoDispose
    .family<List<CandidateModel>, String>((ref, decisionId) {
  final db = ref.watch(databaseProvider);
  final rawCandidatesQuery =
      db.collection('decisions').doc(decisionId).collection('candidates');

  final candidatesQuery = rawCandidatesQuery.withConverter<CandidateModel>(
      fromFirestore: (snapshot, _) => CandidateModel.fromSnapshot(snapshot),
      toFirestore: (candidate, _) => candidate.toMap());

  final candidatesListStream = candidatesQuery
      .snapshots()
      .map((_) => _.docs.map((_) => _.data()).toList());

  return candidatesListStream;
});
