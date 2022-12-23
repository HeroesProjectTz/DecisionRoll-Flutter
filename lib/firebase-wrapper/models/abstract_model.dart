part of '../firebase_wrapper.dart';

abstract class AbstractModel<AM extends AbstractModel<AM, PM>, PM extends PersistedModel<AM, PM>> {
  PM _persistWith(DocumentSnapshot<AM> snapshot);
}