import 'package:cloud_firestore/cloud_firestore.dart';
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
