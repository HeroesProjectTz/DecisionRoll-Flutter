import 'package:decisionroll/models/database/decision_model.dart';
import 'package:decisionroll/providers/database/database_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final userDecisionsProvider =
    StreamProvider.family<List<DocumentSnapshot<DecisionModel>>, String>(
        (ref, ownerId) async* {
  final db = await ref.read(databaseProvider.future);
  debugPrint("userDecisionsStreamProvider for $ownerId");
  if (db != null) {
    yield* db.userDecisions(ownerId);
  }
});
