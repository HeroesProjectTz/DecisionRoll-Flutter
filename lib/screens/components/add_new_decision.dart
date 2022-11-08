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
            decoration: BoxDecoration(
                color: blueColor05, borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12.8),
            child: const Center(
              child: Text(
                "Create",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
