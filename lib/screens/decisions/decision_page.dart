import 'package:decisionroll/common/routes.dart';
import 'package:decisionroll/screens/decisions/candidate_vote_control.dart';
import 'package:decisionroll/screens/decisions/state_transition_button_widget.dart';
import 'package:decisionroll/screens/decisions/status_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:decisionroll/common/my_appbar.dart';
import 'package:decisionroll/common/my_drawer.dart';
import 'package:decisionroll/common/sizeConfig.dart';
import 'package:decisionroll/utilities/colors.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:decisionroll/providers/database/decision_candidates_provider.dart';
import 'package:decisionroll/common/bubble_loading_widget.dart';
import 'package:decisionroll/models/database/candidate_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../common/candidate_colors.dart';
import '../../models/database/decision_model.dart';
import '../../providers/database/database_provider.dart';
import '../../providers/database/decision_account_provider.dart';
import '../../providers/database/decision_candidate_controls_provider.dart';
import '../../providers/database/decision_provider.dart';
import '../decisions/candidate_add_widget.dart';
import 'candidate_vote_controls_widget.dart';
import 'candidates_wheel_widget.dart';
import 'decision_app_bar_widget.dart';

class DecisionPage extends StatelessWidget {
  final String decisionId;

  const DecisionPage({
    Key? key,
    required this.decisionId,
  }) : super(key: key);

  @override
  Widget build(BuildContext c) {
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
