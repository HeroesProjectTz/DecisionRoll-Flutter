import 'package:decisionroll/utilities/colors.dart';
import 'package:flutter/material.dart';

class AddNewDecisionWidget extends StatelessWidget {
  const AddNewDecisionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          flex: 3,
          child: TextField(
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.all(15),
              fillColor: Colors.white,
              filled: true,
              hintText: "Enter your title to create new roll",
              hintStyle: TextStyle(
                color: Color(0xff545454),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: blueColor05,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: const Text(
              "Create",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
