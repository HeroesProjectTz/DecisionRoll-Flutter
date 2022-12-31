import 'package:cloud_firestore/cloud_firestore.dart';
import 'demo_model.dart';
import 'package:decisionroll/firebase-wrapper/firebase_wrapper.dart';

class PersistedDemo extends PersistedModel<DemoModel, PersistedDemo> {
  PersistedDemo.fromSnapshot(snapshot, db) : super.fromSnapshot(snapshot, db);
}
