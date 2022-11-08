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
      //TODO: get decision's documentId and pass to DecisionModel.id
      fromFirestore: (snapshot, _) => DecisionModel.fromMap(snapshot.data()!),
      toFirestore: (decision, _) => decision.toMap());
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

// final adduserDecisionProvider = Provider.family<UserModel, String>((ref, uid) {
//   final db = ref.watch(databaseProvider);
//   final decision = db.collection('decisions').add(DecisionModel(
//           owner: UserModel(
//               uid: uid,
//               name: ref.read(authenticationProvider).getCurrentUserFullName()),
//           title: '',
//           weight: '0')
//       .toJson());
//   return decision;
// });
