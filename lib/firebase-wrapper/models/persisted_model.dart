part of '../firebase_wrapper.dart';

abstract class PersistedModel<AM extends AbstractModel<AM, PM>,
    PM extends PersistedModel<AM, PM>> {
  final DocumentSnapshot<AM> _snapshot;
  final FirestoreDatabase _db;
  late final AM model;

  late final String id = _snapshot.id;

  PersistedModel._(this._db, this._snapshot, this.model);

  PersistedModel.fromSnapshot(this._snapshot, this._db) {
    final maybeModel = _snapshot.data();
    if (maybeModel == null) {
      throw DatabaseValidationException(
          "attempt to reify document with id ${_snapshot.id}, but it was empty");
    }
    model = maybeModel;
  }
}
