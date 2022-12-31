part of '../firebase_wrapper.dart';

class FirestoreDatabase {
  final FirebaseFirestore db;
  final User user;
  late final uid = user.uid;

  FirestoreDatabase({required this.db, required this.user});
}
