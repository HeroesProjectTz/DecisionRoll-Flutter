import 'abstract_binder.dart';
import 'abstract_model.dart';
import 'model_presenter.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class BinderWidget<
    M extends AbstractModel,
    B extends AbstractBinder<M>,
    P extends ModelPresenter<M, B>> extends ConsumerWidget {
  final B binder;
  final P presenter;

  const BinderWidget(
      {required this.binder, required this.presenter, required Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final widgetStream = binder
        .build(ref)
        .map((model) => presenter.build(context, model, binder));

    return presenter.build(context, binder.defaultValue, binder);
  }
}
