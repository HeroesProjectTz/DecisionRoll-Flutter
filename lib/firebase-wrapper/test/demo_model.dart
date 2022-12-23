import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decisionroll/firebase-wrapper/firebase_wrapper.dart';

import 'persisted_demo.dart';

class DemoModel extends AbstractModel<DemoModel, PersistedDemo> {
  final String title;

  DemoModel(this.title);

  @override
  PersistedDemo _persistWith(DocumentSnapshot<DemoModel> snapshot) {
    return PersistedDemo(snapshot, this);
  }
}