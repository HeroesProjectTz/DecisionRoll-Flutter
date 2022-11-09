import 'package:decisionroll/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CandidateVoteControl extends StatelessWidget {
  Color? color;
  CandidateVoteControl(Color purpleColor, {Key? key, color = purpleColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
          decoration: BoxDecoration(
            color: color,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  debugPrint("Decrement");
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                    ),
                  ),
                  child: const Icon(FontAwesomeIcons.angleLeft,
                      color: Colors.white, size: 13),
                ),
              ),
              const Text('0',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
              // SizedBox(width: SizeConfig.screenWidth(c) * 0.01),
              InkWell(
                onTap: () {
                  debugPrint("Increment");
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                    ),
                  ),
                  child: const Icon(FontAwesomeIcons.angleRight,
                      color: Colors.white, size: 13),
                ),
              ),
            ],
          )),
    );
  }
}
