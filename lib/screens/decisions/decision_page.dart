import 'package:decisionroll/screens/components/candidate_vote_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:decisionroll/common/my_appbar.dart';
import 'package:decisionroll/common/my_drawer.dart';
import 'package:decisionroll/common/sizeConfig.dart';
import 'package:decisionroll/utilities/colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:decisionroll/providers/database/decision_candidates_provider.dart';
import 'package:decisionroll/common/bubble_loading_widget.dart';
import 'package:decisionroll/models/database/candidate_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../common/candidate_colors.dart';
import '../../models/database/decision_model.dart';
import '../../providers/database/database_provider.dart';
import '../../providers/database/decision_account_provider.dart';
import '../../providers/database/decision_provider.dart';
import '../components/candidate_add_widget.dart';

class DecisionPage extends ConsumerWidget {
  final String decisionId;

  DecisionPage({
    Key? key,
    required this.decisionId,
  }) : super(key: key);

  MyAppBar _buildAppBarWithTitle(String title) {
    return MyAppBar(
      title: title,
      titlecolor: Colors.white,
      color: blueColor05,
    );
  }

  MyAppBar _buildAppBar(BuildContext c, WidgetRef ref) {
    final decisionAsync = ref.watch(decisionProvider(decisionId));

    return decisionAsync.maybeWhen(
        orElse: () => _buildAppBarWithTitle("Let's Roll"),
        loading: () => _buildAppBarWithTitle("Let's Roll"),
        data: (decision) => _buildAppBarWithTitle(decision.title));
  }

  @override
  Widget build(BuildContext c, WidgetRef ref) {
    return Scaffold(
        // backgroundColor: purpleColor,
        appBar: _buildAppBar(c, ref),
        drawer: const MyDrawer(),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 2.0,
            horizontal: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCandidatesWheel(c, ref),
              // SizedBox(height: SizeConfig.screenHeight(c) * 0.05),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Center(child: _buildStatusText(c, ref)),
                    _buildCandidateVoteControls(c, ref),
                    _buildCandidateAddWidget(c, ref),
                    SizedBox(height: SizeConfig.screenHeight(c) * 0.05),
                    _buildStateTransitionButton(c, ref),
                  ],
                ),
              )
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
                style: TextStyle(
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
    final decisionAsync = ref.watch(decisionProvider(decisionId));

    return decisionAsync.maybeWhen(
        orElse: () => const SizedBox(),
        loading: () => const SizedBox(),
        data: (decision) =>
            _buildStateTransitionButtonFromDecision(c, ref, decision));
  }

  Widget _buildCandidatesWheel(BuildContext c, WidgetRef ref) {
    final candidatesAsync = ref.watch(decisionCandidatesProvider(decisionId));

    return candidatesAsync.maybeWhen(
        orElse: () => const SizedBox(
              child: Text("no dataa..."),
            ),
        loading: () => const BubbleLoadingWidget(),
        data: (candidates) {
          return Container(
              constraints: BoxConstraints(
                  minHeight: SizeConfig.screenHeight(c) * 0.25,
                  maxHeight: SizeConfig.screenHeight(c) * 0.40),
              child: SfCircularChart(series: <CircularSeries>[
                // Renders doughnut chart
                DoughnutSeries<ChartCandidate, String>(
                    animationDuration: 0,
                    animationDelay: 0,
                    dataSource: _buildChartCandidateList(candidates),
                    dataLabelSettings: const DataLabelSettings(
                        isVisible: true, textStyle: TextStyle(fontSize: 12)),
                    dataLabelMapper: (datum, index) {
                      return '${datum.weight}';
                    },
                    pointColorMapper: (ChartCandidate data, _) => data.color,
                    xValueMapper: (ChartCandidate data, _) => data.title,
                    yValueMapper: (ChartCandidate data, _) => data.weight)
              ]));
        });
  }

  List<ChartCandidate> _buildChartCandidateList(
      List<DocumentSnapshot<CandidateModel>> candidates) {
    return candidates.map((candidateSnapshot) {
      final candidateModel = candidateSnapshot.data() ?? CandidateModel.blank();
      final color = CandidateColors.getColorFromIdx(candidateModel.index);
      return ChartCandidate(candidateModel.title, candidateModel.weight, color);
    }).toList();
  }

  Widget _buildStatusTextFromText(String text) {
    return Text(text,
        style: TextStyle(
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

  Widget _buildCandidateVoteControls(BuildContext c, WidgetRef ref) {
    final candidatesAsync = ref.watch(decisionCandidatesProvider(decisionId));

    return SizedBox(
        // height: SizeConfig.screenHeight(c) * 0.3,
        child: candidatesAsync.maybeWhen(
            orElse: () => const SizedBox(
                  child: Text("no dataa..."),
                ),
            loading: () => const BubbleLoadingWidget(),
            data: (candidates) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: candidates.length,
                  itemBuilder: (context, index) {
                    final candidate = candidates[index];
                    return Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: CandidateVoteControl(candidate),
                    );
                  });
            }));
  }

  Widget _buildCandidateAddWidget(BuildContext c, WidgetRef ref) {
    // TODO conditionally include CandidateAddWidget
    // return const SizedBox();
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: CandidateAddWidget(decisionId),
    );
  }
}

class ChartCandidate {
  ChartCandidate(this.title, this.weight, this.color);
  final String title;
  final int weight;
  final Color color;
}
