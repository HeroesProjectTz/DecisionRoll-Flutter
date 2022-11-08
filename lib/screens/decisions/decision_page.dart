import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:decisionroll/common/option_view.dart';
import 'package:decisionroll/common/sizeConfig.dart';
import 'package:decisionroll/common/textfield_widget.dart';
import 'package:decisionroll/utilities/colors.dart';
import 'package:go_router/go_router.dart';

class DecisionPage extends ConsumerWidget {
  final String decisionId;

  DecisionPage({
    Key? key,
    required this.decisionId,
  }) : super(key: key);

  @override
  Widget build(BuildContext c, WidgetRef ref) {
    String goRouterLocation = GoRouter.of(c).location;
    String location = goRouterLocation;

    String locationUid = location.replaceAll("/decision/", "");
    print(locationUid);
    return Scaffold(
        backgroundColor: whiteBackgroundColor,
        appBar: AppBar(
          backgroundColor: whiteBackgroundColor,
          elevation: 0.0,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          title: Text("Roll $locationUid",
              style: const TextStyle(
                color: blueColor,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              )),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 15.0,
            horizontal: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: SizeConfig.screenHeight(c) * 0.1),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFieldWidget(
                        texttFieldController: TextEditingController(),
                        hintText: "Enter Option One"),
                  ),
                  Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: blueColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 5,
                        ),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 15,
                              backgroundColor: blueColor04,
                              child: Icon(FontAwesomeIcons.angleLeft,
                                  color: Colors.white, size: 13),
                            ),
                            SizedBox(width: SizeConfig.screenWidth(c) * 0.01),
                            const CircleAvatar(
                                radius: 17,
                                backgroundColor: whiteBackgroundColor,
                                child: Text('4',
                                    style: TextStyle(
                                      color: blueColor04,
                                      fontWeight: FontWeight.bold,
                                    ))),
                            SizedBox(width: SizeConfig.screenWidth(c) * 0.01),
                            const CircleAvatar(
                              radius: 15,
                              backgroundColor: blueColor04,
                              child: Icon(FontAwesomeIcons.angleRight,
                                  color: Colors.white, size: 13),
                            ),
                          ],
                        ),
                      ))
                ],
              ),
              SizedBox(height: SizeConfig.screenHeight(c) * 0.05),
              Center(
                child: SizedBox(
                  width: SizeConfig.screenWidth(c) / 2,
                  child: InkWell(
                      onTap: () {},
                      child: OptionView(
                        blueColor,
                        "Open Voting",
                        padding: 13,
                      )),
                ),
              ),
            ],
          ),
        ));
  }
}
