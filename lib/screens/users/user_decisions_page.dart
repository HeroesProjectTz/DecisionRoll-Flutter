import 'package:decisionroll/common/bubble_loading_widget.dart';
import 'package:decisionroll/common/my_appbar.dart';
import 'package:decisionroll/common/my_drawer.dart';
import 'package:decisionroll/common/sizeConfig.dart';
import 'package:decisionroll/providers/database/user_decisions_provider.dart';
import 'package:decisionroll/providers/database/user_provider.dart';
import 'package:decisionroll/screens/components/add_new_decision.dart';
import 'package:decisionroll/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/database/database_provider.dart';

class UserDecisionsPage extends ConsumerWidget {
  final String userId;

  const UserDecisionsPage({
    Key? key,
    required this.userId,
  }) : super(key: key);

  PreferredSizeWidget _buildAppBarFromTitle(String title) {
    return MyAppBar(
      title: title,
      titlecolor: Colors.white,
      color: blueColor05,
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext c, WidgetRef ref) {
    return _buildAppBarFromTitle("My Decisions");
    // final userAsync = ref.watch(userProvider(userId));
    // return userAsync.maybeWhen(
    //     orElse: () => _buildAppBarFromTitle("Someone's Decisions"),
    //     data: (user) {
    //       return ref.read(databaseProvider).maybeWhen(
    //           orElse: () => _buildAppBarFromTitle("Someone's Decisions"),
    //           data: (db) {
    //             if (db != null) {
    //               if (db.uid == user.uid) {
    //                 return _buildAppBarFromTitle("My Decisions");
    //               } else {
    //                 return _buildAppBarFromTitle("${user.name}'s Decisions");
    //               }
    //             }
    //             return _buildAppBarFromTitle("Someone's Decisions");
    //           });
    //     });
  }

  @override
  Widget build(BuildContext c, WidgetRef ref) {
    final decisionsAsync = ref.watch(userDecisionsProvider(userId));
    return Scaffold(
      backgroundColor: purpleColor,
      appBar: _buildAppBar(c, ref),
      drawer: const MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 15,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: SizeConfig.screenHeight(c) * 0.02),
          AddNewDecisionWidget(),
          SizedBox(height: SizeConfig.screenHeight(c) * 0.05),
          SizedBox(
            height: SizeConfig.screenHeight(c) * 0.7,
            child: decisionsAsync.maybeWhen(
              orElse: () => const SizedBox(
                child: Text("no data..."),
              ),
              loading: () => const BubbleLoadingWidget(),
              data: (decisions) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: decisions.length,
                    itemBuilder: (context, index) {
                      final decision = decisions[index];
                      return InkWell(
                          onTap: () {
                            GoRouter.of(context).go('/decision/${decision.id}');
                          },
                          child: Container(
                              margin: const EdgeInsets.only(top: 12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 15,
                              ),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Container(
                                          child: boldTextElem(
                                              decision.data()?.title ??
                                                  '<missing title>')),
                                    ),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: paddedWidgetList([
                                          (decision.data()?.outcome != null)
                                              ? propText('Outcome: ',
                                                  decision.data()?.outcome)
                                              : null,
                                          // propText('Owner: ',
                                          //     decision.data()?.ownerId),
                                          propText('State: ',
                                              decision.data()?.state),
                                        ]))
                                  ])));
                    });
              },
            ),
          )
        ]),
      ),
    );
  }

  static Widget boldTextElem(String text) {
    return RichText(
        text: TextSpan(
            text: text,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 15)));
  }

  static List<Widget> paddedWidgetList(List<Widget?> maybeWidgets) {
    final widgets = maybeWidgets.expand((e) => e == null ? [] : [e]);

    return widgets.map((propertyText) {
      return Padding(
          padding: const EdgeInsets.only(top: 12.0), child: propertyText);
    }).toList();
  }

  static Widget propText(String name, String? value) {
    return RichText(
      text: TextSpan(
        text: name,
        style: const TextStyle(
            fontWeight: FontWeight.normal, color: Colors.black, fontSize: 15),
        children: <TextSpan>[
          TextSpan(
              text: value,
              style: const TextStyle(fontWeight: FontWeight.normal)),
          // TextSpan(text: ' world!'),
        ],
      ),
    );
  }
}
