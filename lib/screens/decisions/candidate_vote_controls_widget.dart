import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/database/decision_candidate_controls_provider.dart';
import 'candidate_vote_control.dart';

class CandidateVoteControls extends ConsumerWidget {
  final String decisionId;

  CandidateVoteControls(this.decisionId) : super(key: Key(decisionId));

  @override
  Widget build(BuildContext c, WidgetRef ref) {
    final candidates = ref.watch(decisionCandidateCtrlsProvider(decisionId));
    debugPrint("rebuilding candidate vote controls: $candidates");
    return SizedBox(
        // height: SizeConfig.screenHeight(c) * 0.3,
        child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: candidates.length,
            itemBuilder: (context, index) {
              final candidate = candidates[index];
              return Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: CandidateVoteControl(candidate),
              );
            }));
  }
}
