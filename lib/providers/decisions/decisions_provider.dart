import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decisionroll/models/decisions/decision_model.dart';
import 'package:decisionroll/services/firebase_firestore_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// // UserDecisionsStreamProvider.dart
// final decisionStreamProvider = StreamProvider.autoDispose.family<List<DecisionModel>,String>((ref, ownerId) {
//     final db = ref.read(firebaseFirestoreProvider);
//     final Stream<List<DecisionModel>> userDecisionsStream = db.collection('decisions')
//         .snapshots()
//         .map((decisionsQuerySnapshot) => decisionsQuerySnapshot.docs.map((e) => e.data()))
//     return userDecisionsStream;
// });

final decisionStreamProvider = StreamProvider<QuerySnapshot>((ref) async* {
  yield* ref.read(firebaseFirestoreServiceProvider).streamDecisions();
});

// databaseProvider.dart
final databaseProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

// UserDecisionsStreamProvider.dart
final userDecisionsStreamProvider = StreamProvider.autoDispose
    .family<Iterable<DecisionModel>, String>((ref, ownerId) {
  final db = ref.watch(databaseProvider);
  final decisionsQuery = db.collection('decisions');
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
