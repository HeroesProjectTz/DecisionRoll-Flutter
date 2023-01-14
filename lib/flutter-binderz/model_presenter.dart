import 'package:decisionroll/flutter-binderz/abstract_binder.dart';
import 'package:decisionroll/flutter-binderz/abstract_model.dart';
import 'package:flutter/widgets.dart';

abstract class ModelPresenter<M extends AbstractModel,
    B extends AbstractBinder<M>> {
  Widget build(BuildContext context, M model, B binder);
}
