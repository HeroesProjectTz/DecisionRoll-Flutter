import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decisionroll/providers/authentication/authentication_provider.dart';
import 'package:decisionroll/providers/database/database_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addDecisionProvider =
    FutureProvider.family<DocumentReference, String>((ref, title) async {
  return ref.read(databaseProvider).collection('decisions').add({
    'ownerId': ref.read(authenticationProvider).getCurrentUserUID(),
    'title': title,
    'state': 'new'
  }).then((value) {
    print(value);
    return value;
  });
});
