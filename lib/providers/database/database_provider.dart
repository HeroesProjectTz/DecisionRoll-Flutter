import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:decisionroll/services/firestore_database.dart';
import 'package:decisionroll/providers/authentication/authentication_provider.dart';

final databaseProvider = FutureProvider<FirestoreDatabase?>((ref) async {
  final auth = await ref.read(authStateChangesProvider.future);

  final firebase = FirebaseFirestore.instance;

  // we only have a valid DB if the user is signed in
  if (auth != null) {
    return FirestoreDatabase(db: firebase, uid: auth.uid);
  }
  return null;
});
