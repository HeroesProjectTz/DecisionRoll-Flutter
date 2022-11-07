import 'package:decisionroll/common/option_view.dart';
import 'package:decisionroll/common/sizeConfig.dart';
import 'package:decisionroll/common/textfield_widget.dart';
import 'package:decisionroll/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:decisionroll/models/decisions/decision_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserDecisionDetailsPage extends ConsumerWidget {
  DecisionModel decisionModel;
  UserDecisionDetailsPage({
    Key? key,
    required this.decisionModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        backgroundColor: whiteBackgroundColor,
        appBar: AppBar(
          backgroundColor: whiteBackgroundColor,
          elevation: 0.0,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          title: Text("Roll: ${decisionModel.title}",
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
              SizedBox(height: SizeConfig.screenHeight! * 0.2),
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
                            SizedBox(width: SizeConfig.screenWidth! * 0.01),
                            const CircleAvatar(
                                radius: 17,
                                backgroundColor: whiteBackgroundColor,
                                child: Text('4',
                                    style: TextStyle(
                                      color: blueColor04,
                                      fontWeight: FontWeight.bold,
                                    ))),
                            SizedBox(width: SizeConfig.screenWidth! * 0.01),
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
              SizedBox(height: SizeConfig.screenHeight! * 0.05),
              Center(
                child: SizedBox(
                  width: SizeConfig.screenWidth! / 2,
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
