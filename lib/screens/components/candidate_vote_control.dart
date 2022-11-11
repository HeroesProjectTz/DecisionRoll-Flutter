import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:decisionroll/models/database/candidate_model.dart';
import 'package:decisionroll/common/candidate_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:decisionroll/providers/database/database_provider.dart';

import '../../providers/database/candidate_vote_provider.dart';

class CandidateVoteControl extends ConsumerWidget {
  final DocumentSnapshot<CandidateModel?> candidate;

  CandidateVoteControl(this.candidate) : super(key: Key(candidate.id));

  @override
  Widget build(BuildContext c, WidgetRef ref) {
    final candidateModel = candidate.data() ?? CandidateModel.blank();
    final color = CandidateColors.getColorFromIdx(candidateModel.index);
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 15,
              ),
              decoration: BoxDecoration(border: Border.all(color: color)),
              child: Text(
                candidateModel.title,
                style: const TextStyle(
                  color: Color(
                    0xff545454,
                  ),
                  fontSize: 13,
                ),
              )),
        ),
        _buildVotingButtons(c, ref, candidate, color),
      ],
    );
  }

  Widget _buildYourVoteTextFromWeight(int weight) {
    return Text(weight.toString(),
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ));
  }

  Widget _buildYourVoteText(BuildContext c, WidgetRef ref,
      DocumentSnapshot<CandidateModel?> candidate) {
    final voteAsync = ref.watch(candidateVoteProvider(candidate));
    return voteAsync.maybeWhen(
        orElse: () => const SizedBox(),
        // loading: () => _buildYourVoteTextFromWeight(10),
        data: (vote) {
          return _buildYourVoteTextFromWeight(vote.weight);
        });
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
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 13),
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
              _buildYourVoteText(c, ref, candidate),
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
