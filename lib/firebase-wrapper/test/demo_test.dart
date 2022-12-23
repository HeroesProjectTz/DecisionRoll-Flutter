import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decisionroll/firebase-wrapper/firebase_wrapper.dart';

import 'demo_model.dart';
import 'persisted_demo.dart';

DocumentSnapshot<DemoModel> makeDemoSnapshot() {
  throw UnimplementedError();
}

void main() {
  final DocumentSnapshot<DemoModel> demoSnapshot = makeDemoSnapshot();
  final maybePersistedDemo = safelyWrapDocumentSnapshot<DemoModel, PersistedDemo>(demoSnapshot).getRight();
}