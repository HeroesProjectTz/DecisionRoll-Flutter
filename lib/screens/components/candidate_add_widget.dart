import 'package:decisionroll/common/candidate_colors.dart';
import 'package:decisionroll/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/database/decision_model.dart';
import '../../providers/database/database_provider.dart';
import '../../providers/database/decision_provider.dart';

class CandidateAddWidget extends ConsumerWidget {
  final String decisionId;

  CandidateAddWidget(this.decisionId) : super(key: Key(decisionId));

  final TextEditingController titleController = TextEditingController();

  Widget build(BuildContext c, WidgetRef ref) {
    final decisionAsync = ref.watch(decisionProvider(decisionId));

    return decisionAsync.maybeWhen(
        orElse: () => const SizedBox(),
        loading: () => const SizedBox(),
        data: (decision) => _buildWithDecision(c, ref, decision));
  }

  Widget _buildWithDecision(
      BuildContext c, WidgetRef ref, DecisionModel decision) {
    final nextIndex = decision.nextIndex;
    final color = CandidateColors.getColorFromIdx(nextIndex);
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
            hintText: "Enter option ${nextIndex + 1}",
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
            color: color,
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
