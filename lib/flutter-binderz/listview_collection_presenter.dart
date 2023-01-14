import 'package:decisionroll/flutter-binderz/abstract_binder.dart';
import 'package:decisionroll/flutter-binderz/abstract_model.dart';
import 'package:decisionroll/flutter-binderz/model_presenter.dart';
import 'package:flutter/widgets.dart';

import 'collection_presenter.dart';

class ListViewCollectionPresenter<
    M extends AbstractModel,
    B extends AbstractBinder<M>,
    MP extends ModelPresenter<M, B>> extends CollectionPresenter<M, B, MP> {
  @override
  Widget render(BuildContext context, bool awaitingData, int itemCount,
      List<Widget> Function() renderCollection) {
    final items = renderCollection();
    return ListView.builder(
        itemCount: itemCount, itemBuilder: (context, index) => items[index]);
  }
}
