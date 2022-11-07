import 'package:decisionroll/common/bubble_loading_widget.dart';
import 'package:decisionroll/common/my_appbar.dart';
import 'package:decisionroll/common/my_drawer.dart';
import 'package:decisionroll/models/decisions/decision_model.dart';
import 'package:decisionroll/providers/decisions/user_decisions_stream_provider.dart';
import 'package:decisionroll/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserDecisionsPage extends ConsumerWidget {
  final String userId;

  UserDecisionsPage({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("user decisions page: $userId");
    final decisionsAsync = ref.watch(userDecisionsStreamProvider(userId));
    return Scaffold(
      backgroundColor: whiteBackgroundColor,
      appBar: MyAppBar(),
      drawer: MyDrawer(),
      body: decisionsAsync.maybeWhen(
          orElse: () => const SizedBox(
                child: Text("no dataa..."),
              ),
          loading: () => const BubbleLoadingWidget(),
          data: (decisions) {
            final decisionsList = decisions.toList();
            return ListView.builder(
              shrinkWrap: true,
              itemCount: decisionsList.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 15,
                ),
                child: Text(decisionsList[index].title),
              ),
            );
          }),
    );
  }
}
