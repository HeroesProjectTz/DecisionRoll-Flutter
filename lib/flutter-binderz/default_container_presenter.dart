import 'package:decisionroll/flutter-binderz/abstract_binder.dart';
import 'package:decisionroll/flutter-binderz/abstract_model.dart';
import 'package:decisionroll/flutter-binderz/model_presenter.dart';
import 'package:flutter/widgets.dart';

import 'container_presenter.dart';

class DefaultContainerPresenter<
    M extends AbstractModel,
    B extends AbstractBinder<M>,
    MP extends ModelPresenter<M, B>> extends ContainerPresenter<M, B, MP> {
  @override
  Widget render(
      BuildContext context, bool awaitingData, Widget Function() renderBody) {
    return renderBody();
  }
}
