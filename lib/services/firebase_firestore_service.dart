import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FirebaseFirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // STREAM Course List METHOD
  Stream<QuerySnapshot> streamDecisions() {
    return _db.collection('decisions').snapshots();
  }
}

final firebaseFirestoreServiceProvider =
    Provider<FirebaseFirestoreService>((ref) {
  return FirebaseFirestoreService();
});
