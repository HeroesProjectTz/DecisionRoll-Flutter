import 'package:decisionroll/flutter-binderz/abstract_binder.dart';
import 'package:decisionroll/flutter-binderz/abstract_model.dart';
import 'package:decisionroll/flutter-binderz/model_presenter.dart';
import 'package:flutter/widgets.dart';

abstract class ContainerPresenter<M extends AbstractModel,
    B extends AbstractBinder<M>, MP extends ModelPresenter<M, B>> {
  Widget render(
      BuildContext context, bool awaitingData, Widget Function() renderBody);
}
