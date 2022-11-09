import 'package:decisionroll/models/database/candidate_model.dart';
import 'package:decisionroll/providers/database/database_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final decisionCandidatesProvider = StreamProvider.autoDispose
    .family<List<DocumentSnapshot<CandidateModel>>, String>(
        (ref, decisionId) async* {
  final db = await ref.watch(databaseProvider.future);
  if (db != null) {
    yield* db.decisionCandidates(decisionId);
  }
});
