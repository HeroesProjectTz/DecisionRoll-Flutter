import 'package:decisionroll/common/routes.dart';
import 'package:decisionroll/screens/decisions/candidate_vote_control.dart';
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

class DecisionPage extends ConsumerWidget {
  final String decisionId;

  const DecisionPage({
    Key? key,
    required this.decisionId,
  }) : super(key: key);

  @override
  Widget build(BuildContext c, WidgetRef ref) {
    debugPrint("rebuilding decision $decisionId. ${c.debugDoingBuild}");
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
                    Center(child: _buildStatusText(c, ref)),
                    CandidateVoteControls(decisionId),
                    CandidateAddWidget(decisionId),
                    SizedBox(height: SizeConfig.screenHeight(c) * 0.05),
                    _buildStateTransitionButton(c, ref),
                  ],
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight(c) * 0.05),
            ],
          ),
        ));
  }

  String _buttonTextFromState(String state) {
    switch (state) {
      case 'new':
        return 'Open Voting';
      case 'open':
        return 'Close Voting';
      case 'closed':
        return "Let's Roll!";
      case 'finished':
        return "Re-open Voting";
      default:
        return "Close Voting";
    }
  }

  Widget _buildStateTransitionButtonFromDecision(
      BuildContext c, WidgetRef ref, DecisionModel decision) {
    return Center(
      child: SizedBox(
        width: SizeConfig.screenWidth(c) / 1.6,
        child: InkWell(
          onTap: () {
            ref.read(databaseProvider).whenData((db) async {
              if (db != null) {
                db.advanceDecisionState(decisionId);
              }
            });
          },
          child: Container(
            decoration: const BoxDecoration(color: blueColor05),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12.8),
            child: Center(
              child: Text(
                _buttonTextFromState(decision.state),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStateTransitionButton(BuildContext c, WidgetRef ref) {
    return ref.read(databaseProvider).maybeWhen(
        orElse: () => const SizedBox(),
        loading: () => const SizedBox(),
        data: (db) {
          final decisionAsync = ref.watch(decisionProvider(decisionId));
          return decisionAsync.maybeWhen(
              orElse: () => const SizedBox(),
              loading: () => const SizedBox(),
              data: (decision) {
                if (db != null && decision.ownerId != db.uid) {
                  return const SizedBox();
                }
                return _buildStateTransitionButtonFromDecision(
                    c, ref, decision);
              });
        });
  }

  Widget _buildStatusTextFromText(String text) {
    return Text(text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ));
  }

  Widget _buildStatusText(BuildContext c, WidgetRef ref) {
    final decisionAsync = ref.watch(decisionProvider(decisionId));

    return decisionAsync.maybeWhen(
        orElse: () => const SizedBox(),
        loading: () => const SizedBox(),
        data: (decision) {
          switch (decision.state) {
            case 'new':
              return _buildStatusTextFromText("Wait for voting to start.");
            case 'open':
              {
                final accountAsync =
                    ref.watch(decisionAccountProvider(decisionId));
                return accountAsync.maybeWhen(
                    orElse: () => const SizedBox(
                          child: Text("no dataa..."),
                        ),
                    loading: () => const BubbleLoadingWidget(),
                    data: (account) {
                      final balance = account.balance;
                      return _buildStatusTextFromText(
                          "you have $balance votes remaining");
                    });
              }
            case 'closed':
              return _buildStatusTextFromText("Voting has closed.");
            case 'finished':
              {
                if (decision.outcome != null) {
                  return _buildStatusTextFromText(
                      "Outcome: ${decision.outcome}");
                } else {
                  return _buildStatusTextFromText("<outcome missing>");
                }
              }
            default:
              return _buildStatusTextFromText("<invalid state>");
          }
        });
  }
}
