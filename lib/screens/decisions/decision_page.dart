import 'package:decisionroll/screens/decisions/state_transition_button_widget.dart';
import 'package:decisionroll/screens/decisions/status_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:decisionroll/common/my_drawer.dart';
import 'package:decisionroll/common/sizeConfig.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../decisions/candidate_add_widget.dart';
import 'candidate_vote_controls_widget.dart';
import 'candidates_wheel_widget.dart';
import 'decision_app_bar_widget.dart';

class DecisionPage extends ConsumerWidget {
  final String decisionId;

  const DecisionPage({
    Key? key,
    required this.decisionId,
  }) : super(key: key);

  @override
  Widget build(BuildContext c, WidgetRef ref) {
    return Scaffold(
        // backgroundColor: purpleColor,
        appBar: DecisionAppBar(decisionId),
        drawer: const MyDrawer(),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 2.0,
            horizontal: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CandidatesWheel(decisionId),
              Expanded(
                // height: SizeConfig.screenHeight(c) * 0.3,
                child: ListView(
                  // shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    Center(child: StatusText(decisionId)),
                    CandidateVoteControls(decisionId),
                    CandidateAddWidget(decisionId),
                    SizedBox(height: SizeConfig.screenHeight(c) * 0.05),
                    StateTransitionButton(decisionId),
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight(c) * 0.05),
            ],
          ),
        ));
  }
}
