import 'package:decisionroll/common/bubble_loading_widget.dart';
import 'package:decisionroll/common/my_appbar.dart';
import 'package:decisionroll/common/my_drawer.dart';
import 'package:decisionroll/common/option_view.dart';
import 'package:decisionroll/common/sizeConfig.dart';
import 'package:decisionroll/common/textfield_widget.dart';
import 'package:decisionroll/models/decisions/decision_model.dart';
import 'package:decisionroll/models/decisions/user_model.dart';
import 'package:decisionroll/providers/authentication/authentication_provider.dart';
import 'package:decisionroll/providers/decisions/user_decisions_stream_provider.dart';
import 'package:decisionroll/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class UserDecisionsPage extends ConsumerWidget {
  final String userId;

  UserDecisionsPage({
    Key? key,
    required this.userId,
  }) : super(key: key);
  final TextEditingController newDecisionController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("user decisions page: $userId");
    final decisionsAsync = ref.watch(userDecisionsStreamProvider(userId));
    return Scaffold(
      backgroundColor: whiteBackgroundColor,
      appBar: const MyAppBar(title: 'My Decisions'),
      drawer: MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: SizeConfig.screenHeight! * 0.1,
              width: SizeConfig.screenWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: TextFieldWidget(
                        texttFieldController: newDecisionController,
                        hintText: "Enter your title to create new roll"),
                  ),
                  SizedBox(
                    child: InkWell(
                        child: OptionView(
                      blueColor02,
                      "Create",
                      padding: 10,
                    )),
                  )
                ],
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight! * 0.05),
            decisionsAsync.maybeWhen(
                orElse: () => const SizedBox(
                      child: Text("no dataa..."),
                    ),
                loading: () => const BubbleLoadingWidget(),
                data: (decisions) {
                  final decisionsList = decisions.toList();
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: decisionsList.length,
                    itemBuilder: (context, index) =>
                        // Text(decisionsList[index].title),
                        InkWell(
                      onTap: () {
                        GoRouter.of(context).push(
                            '/decision/${ref.read(authenticationProvider).getCurrentUserUID()}/details',
                            extra: DecisionModel(
                                owner: UserModel(name: '', uid: ''),
                                weight: '0',
                                title: decisionsList[index].title));
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            color: blueColor02,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 15,
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: 'Roll: ',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 15),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: decisionsList[index].title,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      // TextSpan(text: ' world!'),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 12.0),
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'Outcome: ',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 15),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: decisionsList[index].title,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        // TextSpan(text: ' world!'),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 12.0),
                                  child: RichText(
                                    text: const TextSpan(
                                      text: 'Owner: ',
                                      style: TextStyle(
                                          // fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 13),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: "Eliza",
                                        ),
                                        // TextSpan(text: ' world!'),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 12.0),
                                  child: RichText(
                                    text: const TextSpan(
                                      text: 'Status: ',
                                      style: TextStyle(
                                          // fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 13),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Open',
                                        ),
                                        // TextSpan(text: ' world!'),
                                      ],
                                    ),
                                  ),
                                ),
                              ])),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
