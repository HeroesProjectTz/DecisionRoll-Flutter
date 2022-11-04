import 'package:decisionroll/common/bubble_loading_widget.dart';
import 'package:decisionroll/common/my_appbar.dart';
import 'package:decisionroll/common/my_drawer.dart';
import 'package:decisionroll/models/decisions/decision_model.dart';
import 'package:decisionroll/providers/decisions/decisions_provider.dart';
import 'package:decisionroll/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ignore: must_be_immutable
class UserDecisionsPage extends ConsumerWidget {
  String userId;
  UserDecisionsPage({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final decisions = ref.watch(decisionStreamProvider);
    return Scaffold(
      backgroundColor: whiteBackgroundColor,
      appBar: const MyAppBar(),
      drawer: MyDrawer(),
      body: decisions.maybeWhen(
          orElse: () => const SizedBox(
                child: Text("no dataa..."),
              ),
          loading: () => const BubbleLoadingWidget(),
          data: (decision) {
            final decisionList = decision.docs
                .map((decision) => DecisionModel.fromMap(
                    decision.data() as Map<String, dynamic>))
                .toList();
            return ListView.builder(
              shrinkWrap: true,
              itemCount: decisionList.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 15,
                ),
                child: Text(decisionList[index].title),
              ),
            );
          }),
    );
  }
}
