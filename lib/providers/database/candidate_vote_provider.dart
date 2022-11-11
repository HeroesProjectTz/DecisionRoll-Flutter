import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decisionroll/providers/database/database_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/database/account_model.dart';
import '../../models/database/candidate_ctrl.dart';
import '../../models/database/candidate_model.dart';
import '../../models/database/vote_model.dart';

final candidateVoteProvider = StreamProvider.autoDispose
    .family<VoteModel, CandidateCtrl>((ref, candidate) async* {
  final decisionId = candidate.decisionId;
  final candidateId = candidate.id;
  final db = await ref.watch(databaseProvider.future);
  if (db != null) {
    yield* db
        .getMyVoteForCandidate(decisionId, candidateId)
        .snapshots()
        .map((doc) {
      return doc.data() ?? VoteModel.blank();
    });
  }
});
