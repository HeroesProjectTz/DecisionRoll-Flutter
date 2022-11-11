import 'package:decisionroll/models/database/candidate_ctrl.dart';
import 'package:decisionroll/providers/database/database_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/firestore_database.dart';

class CandidateCtrlsNotifier extends StateNotifier<List<CandidateCtrl>> {
  final String decisionId;
  final Future<FirestoreDatabase?> dbf;

  CandidateCtrlsNotifier(this.dbf, this.decisionId) : super([]) {
    dbf.then((db) {
      if (db != null) {
        db.decisionCandidates(decisionId).listen((candidates) {
          state = candidates.map((snapshot) {
            return CandidateCtrl.fromModelSnapshot(snapshot);
          }).toList();
        });
      }
    });
  }
  @override
  bool updateShouldNotify(
      List<CandidateCtrl> old, List<CandidateCtrl> newValue) {
    return old.length != newValue.length;
  }
}

//final candidatesStateProvider = StateNotifier<List<CandidateCtrl>>((_) => []);

final decisionCandidateCtrlsProvider = StateNotifierProvider.family<
    CandidateCtrlsNotifier, List<CandidateCtrl>, String>((ref, decisionId) {
  final db = ref.read(databaseProvider.future);
  return CandidateCtrlsNotifier(db, decisionId);
});
