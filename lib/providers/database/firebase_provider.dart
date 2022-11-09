import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);
