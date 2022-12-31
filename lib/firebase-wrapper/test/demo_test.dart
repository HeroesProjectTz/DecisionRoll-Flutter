import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decisionroll/firebase-wrapper/firebase_wrapper.dart';

import 'demo_model.dart';
import 'persisted_demo.dart';

DocumentSnapshot<DemoModel> makeDemoSnapshot() {
  throw UnimplementedError();
}

FirestoreDatabase getDb() {
  throw UnimplementedError();
}

void main() {
  final DocumentSnapshot<DemoModel> demoSnapshot = makeDemoSnapshot();
  final db = getDb();
  final demoModel = DemoModel("test");
  final maybePersistedDemo =
      safelyWrapDocumentSnapshot<DemoModel, PersistedDemo>(demoSnapshot)
          .getRight();
  final persistedDemo = PersistedDemo.fromSnapshot(demoSnapshot, db);
}
