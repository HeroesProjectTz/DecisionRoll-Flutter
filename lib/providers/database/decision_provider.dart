import 'package:decisionroll/providers/database/database_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/database/decision_model.dart';

final decisionProvider = StreamProvider.autoDispose
    .family<DecisionModel, String>((ref, decisionId) async* {
  final db = await ref.watch(databaseProvider.future);
  if (db != null) {
    yield* db.getDecision(decisionId).snapshots().map((doc) {
      return doc.data() ?? DecisionModel.blank();
    });
  }
});
