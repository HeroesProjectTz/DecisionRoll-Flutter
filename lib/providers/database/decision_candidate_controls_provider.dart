import 'package:decisionroll/models/database/candidate_ctrl.dart';
import 'package:decisionroll/models/database/user_model.dart';
import 'package:decisionroll/providers/database/database_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../services/firestore_database.dart';

class CandidateCtrlsNotifier extends StateNotifier<List<CandidateCtrl>> {
  final String decisionId;
  final Future<FirestoreDatabase?> dbf;

  CandidateCtrlsNotifier(this.dbf, this.decisionId) : super([]) {
    dbf.then((db) {
      if (db != null) {
        db.decisionCandidates(decisionId).listen((event) {
          state = event.map((snapshot) {
            return CandidateCtrl.fromModelSnapshot(snapshot);
          }).toList();
        });
      }
    });
  }
}

//final candidatesStateProvider = StateNotifier<List<CandidateCtrl>>((_) => []);

final decisionCandidateCtrlsProvider = StateNotifierProvider.family<
    CandidateCtrlsNotifier, List<CandidateCtrl>, String>((ref, decisionId) {
  final db = ref.read(databaseProvider.future);
  return CandidateCtrlsNotifier(db, decisionId);
});
