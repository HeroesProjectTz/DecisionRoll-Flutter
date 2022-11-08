import 'package:decisionroll/models/database/decision_model.dart';
import 'package:decisionroll/providers/database/database_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userDecisionsStreamProvider =
    StreamProvider.family<List<DecisionModel>, String>((ref, ownerId) {
  final db = ref.watch(databaseProvider);
  final rawDecisionsQuery =
      db.collection('decisions').where('ownerId', isEqualTo: ownerId);
  final decisionsQuery = rawDecisionsQuery.withConverter<DecisionModel>(
      fromFirestore: (snapshot, _) => DecisionModel.fromSnapshot(snapshot),
      toFirestore: (decision, _) => decision.toMap());

  final decisionListStream = decisionsQuery
      .snapshots()
      .map((_) => _.docs.map((_) => _.data()).toList());

  return decisionListStream;
});
