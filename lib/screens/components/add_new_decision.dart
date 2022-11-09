import 'package:decisionroll/providers/database/add_new_decision.dart';
import 'package:decisionroll/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddNewDecisionWidget extends ConsumerWidget {
  AddNewDecisionWidget({
    Key? key,
  }) : super(key: key);

  final TextEditingController titleController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: TextField(
            controller: titleController,
            decoration: const InputDecoration(
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
          child: InkWell(
            onTap: () {
              debugPrint("tapped here");

              if (titleController.text != '') {
                ref.read(addDecisionProvider(titleController.text));
                debugPrint("tapped");
                titleController.clear();
              }
            },
            child: Container(
              decoration: BoxDecoration(
                  color: blueColor05, borderRadius: BorderRadius.circular(8)),
              padding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 12.8),
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
        ),
      ],
    );
  }
}
