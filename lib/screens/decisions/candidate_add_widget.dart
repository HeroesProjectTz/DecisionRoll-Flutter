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

  @override
  Widget build(BuildContext c, WidgetRef ref) {
    return _buildCandidateAddWidget(c, ref);
  }

  Widget _buildWithDecision(
      BuildContext c, WidgetRef ref, DecisionModel decision) {
    final nextIndex = decision.nextIndex;
    final color = CandidateColors.getColorFromIdx(nextIndex);
    return Row(children: [
      Expanded(
        flex: 3,
        child: TextField(
          onSubmitted: (value) {
            _candidateAddOnSubmit(c, ref);
          },
          controller: titleController,
          decoration: InputDecoration(
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            isDense: true,
            contentPadding: const EdgeInsets.all(15),
            fillColor: Colors.white,
            filled: true,
            hintText: "Enter option ${nextIndex + 1}",
            hintStyle: const TextStyle(
              color: Color(0xff545454),
            ),
          ),
        ),
      ),
      Expanded(
        flex: 1,
        child: InkWell(
          onTap: () {
            _candidateAddOnSubmit(c, ref);
          },
          child: Container(
            color: color,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10.5),
            child: const Center(
              child: Text("Add",
                  style: TextStyle(
                    color: Colors.white,
                  )),
            ),
          ),
        ),
      ),
      // CandidateVoteControl(purpleColor),
    ]);
  }

  _candidateAddOnSubmit(BuildContext c, WidgetRef ref) {
    ref.read(databaseProvider).whenData((db) async {
      if (db != null) {
        db.addCandidateByTitle(decisionId, titleController.text);
      }
    });
    debugPrint("Add ${titleController.text}");
    titleController.clear();
  }

  Widget _buildCandidateAddWidget(BuildContext c, WidgetRef ref) {
    return ref.read(databaseProvider).maybeWhen(
        orElse: () => const SizedBox(),
        loading: () => const SizedBox(),
        data: (db) {
          if (db != null) {
            final decisionAsync = ref.watch(decisionProvider(decisionId));
            return decisionAsync.maybeWhen(
                orElse: () => const SizedBox(),
                loading: () => const SizedBox(),
                data: (decision) {
                  if (decision.ownerId == db.uid) {
                    return Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: _buildWithDecision(c, ref, decision));
                  }
                  return const SizedBox();
                });
          }
          return const SizedBox();
        });
  }
}
