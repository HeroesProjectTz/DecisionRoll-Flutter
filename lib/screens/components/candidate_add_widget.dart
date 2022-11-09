import 'package:decisionroll/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/database/database_provider.dart';

class CandidateAddWidget extends ConsumerWidget {
  final String decisionId;

  CandidateAddWidget(this.decisionId) : super(key: Key(decisionId));
  final TextEditingController titleController = TextEditingController();
  Widget build(BuildContext c, WidgetRef ref) {
    return Row(children: [
      Expanded(
        flex: 3,
        child: TextField(
          controller: titleController,
          decoration: InputDecoration(
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
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
        child: InkWell(
          onTap: () {
            ref.read(databaseProvider).whenData((db) async {
              if (db != null) {
                db.addCandidateByTitle(decisionId, titleController.text);
              }
            });
            debugPrint("Add ${titleController.text}");
          },
          child: Container(
            color: blueColor05,
            child: Center(
              child: Text("Add",
                  style: TextStyle(
                    color: Colors.white,
                  )),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10.5),
          ),
        ),
      ),
      // CandidateVoteControl(purpleColor),
    ]);
  }
}
