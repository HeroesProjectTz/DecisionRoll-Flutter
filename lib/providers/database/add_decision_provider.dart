import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decisionroll/common/routes.dart';
import 'package:decisionroll/providers/authentication/authentication_provider.dart';
import 'package:decisionroll/providers/database/firebase_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final addDecisionProvider =
    FutureProvider.family<DocumentReference, String>((ref, title) async {
  return ref.read(firebaseProvider).collection('decisions').add({
    'ownerId': ref.read(authenticationProvider).getCurrentUserUID(),
    'title': title,
    'state': 'new'
  }).then((value) {
    goRouter.go('/decision/${value.id}');

    return value;
  });
});
