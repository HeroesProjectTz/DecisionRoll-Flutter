import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'abstract_model.dart';

abstract class AbstractBinder<M extends AbstractModel> {
  final M defaultValue;

  const AbstractBinder(this.defaultValue);

  Stream<M> build(WidgetRef ref);
}
