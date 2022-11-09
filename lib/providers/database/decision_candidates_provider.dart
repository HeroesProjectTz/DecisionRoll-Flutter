import 'package:decisionroll/models/database/candidate_model.dart';
import 'package:decisionroll/providers/database/database_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final decisionCandidatesProvider = StreamProvider.autoDispose
    .family<List<CandidateModel>, String>((ref, decisionId) async* {
  final db = await ref.watch(databaseProvider.future);
  if (db != null) {
    yield* db.decisionCandidates(decisionId);
  }
});
