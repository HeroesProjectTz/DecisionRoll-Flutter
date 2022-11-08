import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:decisionroll/common/my_appbar.dart';
import 'package:decisionroll/common/my_drawer.dart';
import 'package:decisionroll/common/option_view.dart';
import 'package:decisionroll/common/sizeConfig.dart';
import 'package:decisionroll/utilities/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class DecisionPage extends ConsumerWidget {
  final String decisionId;

  const DecisionPage({
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
        backgroundColor: purpleColor,
        appBar: const MyAppBar(
          title: 'Roll',
          titlecolor: Colors.white,
          color: blueColor05,
        ),
        drawer: const MyDrawer(),
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
                children: [
                  const Expanded(
                    flex: 2,
                    child: TextField(
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.all(15),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Enter option 1",
                        hintStyle: TextStyle(
                          color: Color(0xff545454),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                        color: blueColor05,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 10),
                        child: Row(
                          children: const [
                            Expanded(
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: blueColor04,
                                child: Icon(FontAwesomeIcons.angleLeft,
                                    color: Colors.white, size: 13),
                              ),
                            ),
                            // SizedBox(width: SizeConfig.screenWidth(c) * 0.01),
                            Expanded(
                              child: CircleAvatar(
                                  radius: 17,
                                  backgroundColor: whiteBackgroundColor,
                                  child: Text('0',
                                      style: TextStyle(
                                        color: blueColor04,
                                        fontWeight: FontWeight.bold,
                                      ))),
                            ),
                            // SizedBox(width: SizeConfig.screenWidth(c) * 0.01),
                            Expanded(
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: blueColor04,
                                child: Icon(FontAwesomeIcons.angleRight,
                                    color: Colors.white, size: 13),
                              ),
                            ),
                          ],
                        )),
                  ),
                ],
              ),
              SizedBox(height: SizeConfig.screenHeight(c) * 0.05),
              Center(
                child: SizedBox(
                  width: SizeConfig.screenWidth(c) / 1.6,
                  child: InkWell(
                      onTap: () {},
                      child: OptionView(
                        blueColor05,
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
