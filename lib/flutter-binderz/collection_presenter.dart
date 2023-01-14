import 'package:decisionroll/flutter-binderz/abstract_binder.dart';
import 'package:decisionroll/flutter-binderz/abstract_model.dart';
import 'package:decisionroll/flutter-binderz/model_presenter.dart';
import 'package:flutter/widgets.dart';

abstract class CollectionPresenter<M extends AbstractModel,
    B extends AbstractBinder<M>, MP extends ModelPresenter<M, B>> {
  Widget render(BuildContext context, bool awaitingData, int itemCount,
      List<Widget> Function() renderCollection);
}
