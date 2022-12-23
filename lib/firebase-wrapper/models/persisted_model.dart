part of '../firebase_wrapper.dart';

abstract class PersistedModel<AM extends AbstractModel<AM, PM>, PM extends PersistedModel<AM, PM>> {
  final DocumentSnapshot<AM> _snapshot;
  final AM model;

  late final String id = _snapshot.id;

  PersistedModel(this._snapshot, this.model);
}