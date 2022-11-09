import 'package:decisionroll/utilities/colors.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:decisionroll/models/database/candidate_model.dart';
import 'package:decisionroll/common/candidate_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:decisionroll/providers/database/database_provider.dart';

class CandidateVoteControl extends ConsumerWidget {
  final DocumentSnapshot<CandidateModel?> candidate;

  CandidateVoteControl(this.candidate) : super(key: Key(candidate.id));

  Widget build(BuildContext c, WidgetRef ref) {
    final candidateModel = candidate.data() ?? CandidateModel.blank();
    final color = CandidateColors.getColorFromIdx(candidateModel.colorIdx);
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 15,
              ),
              child: Text(
                candidateModel.title,
                style: TextStyle(
                  color: Color(
                    0xff545454,
                  ),
                  fontSize: 13,
                ),
              ),
              decoration: BoxDecoration(border: Border.all(color: color))),
        ),
        _buildVotingButtons(c, ref, candidate, color),
      ],
    );
  }

  Widget _buildVotingButtons(BuildContext c, WidgetRef ref,
      DocumentSnapshot<CandidateModel?> candidate, Color color) {
    final decisionId =
        candidate.reference.parent.parent?.id ?? "decision-parent-missing";
    final candidateId = candidate.id;
    final candidateModel = candidate.data() ?? CandidateModel.blank();

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
                  ref.read(databaseProvider).whenData((db) async {
                    if (db != null) {
                      db.decrementVote(decisionId, candidateId);
                    }
                  });
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
              Text(candidateModel.weight.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
              // SizedBox(width: SizeConfig.screenWidth(c) * 0.01),
              InkWell(
                onTap: () {
                  ref.read(databaseProvider).whenData((db) async {
                    if (db != null) {
                      db.incrementVote(decisionId, candidateId);
                    }
                  });
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
