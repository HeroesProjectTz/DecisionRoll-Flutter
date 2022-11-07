import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decisionroll/models/decisions/decision_model.dart';
import 'package:decisionroll/providers/database/database_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userDecisionsStreamProvider =
    StreamProvider.family<Iterable<DecisionModel>, String>((ref, ownerId) {
  final db = ref.watch(databaseProvider);
  final decisionsQuery =
      db.collection('decisions').where('ownerId', isEqualTo: ownerId);
  final decisionsRef = decisionsQuery.withConverter<DecisionModel>(
      fromFirestore: (snapshot, _) => DecisionModel.fromMap(snapshot.data()!),
      toFirestore: (decision, _) => decision.toJson());
  final Stream<QuerySnapshot<DecisionModel>> decisionQuerySnapshotStream =
      decisionsRef.snapshots();

  final decisionQueryDocumentSnapshotListStream = decisionQuerySnapshotStream
      .map((decisionsQuerySnapshot) => decisionsQuerySnapshot.docs);

  final decisionListStream = decisionQueryDocumentSnapshotListStream // stream
      .map((decisionQueryDocumentSnapshotList) => //list
          decisionQueryDocumentSnapshotList.map(
              (decisionQueryDocumentSnapshot) => // QueryDocumentSnapshot
                  decisionQueryDocumentSnapshot
                      .data() // expect return: single DecisionModel
              ));

  return decisionListStream;
});
