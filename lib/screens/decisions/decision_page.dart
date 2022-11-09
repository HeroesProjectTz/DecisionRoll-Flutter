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
import '../../providers/database/decision_account_provider.dart';
import '../../providers/database/decision_provider.dart';
import '../components/candidate_add_widget.dart';

class DecisionPage extends ConsumerWidget {
  final String decisionId;

  DecisionPage({
    Key? key,
    required this.decisionId,
  }) : super(key: key);

  final List<ChartCandidate> chartData = [
    ChartCandidate('werewolf', 25, const Color.fromRGBO(9, 0, 136, 1)),
    ChartCandidate('charades', 38, const Color.fromRGBO(147, 0, 119, 1)),
    ChartCandidate('burrito', 34, const Color.fromRGBO(228, 0, 124, 1)),
    ChartCandidate('hike', 52, const Color.fromRGBO(255, 189, 57, 1))
  ];

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
            vertical: 15.0,
            horizontal: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCandidatesWheel(c, ref),
              SizedBox(height: SizeConfig.screenHeight(c) * 0.05),
              Center(child: _buildStatusText(c, ref)),
              _buildCandidateVoteControls(c, ref),
              _buildCandidateAddWidget(c, ref),
              SizedBox(height: SizeConfig.screenHeight(c) * 0.05),
              Center(
                child: SizedBox(
                  width: SizeConfig.screenWidth(c) / 1.6,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      decoration: const BoxDecoration(color: blueColor05),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 12.8),
                      child: const Center(
                        child: Text(
                          "Open Voting",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildCandidatesWheel(BuildContext c, WidgetRef ref) {
    final candidatesAsync = ref.watch(decisionCandidatesProvider(decisionId));

    return candidatesAsync.maybeWhen(
        orElse: () => const SizedBox(
              child: Text("no dataa..."),
            ),
        loading: () => const BubbleLoadingWidget(),
        data: (candidates) {
          return Expanded(
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
      final color = CandidateColors.getColorFromIdx(candidateModel.colorIdx);
      return ChartCandidate(candidateModel.title, candidateModel.weight, color);
    }).toList();
  }

  Widget _buildStatusText(BuildContext c, WidgetRef ref) {
    final accountAsync = ref.watch(decisionAccountProvider(decisionId));
    return accountAsync.maybeWhen(
        orElse: () => const SizedBox(
              child: Text("no dataa..."),
            ),
        loading: () => const BubbleLoadingWidget(),
        data: (account) {
          final balance = account.balance;
          return Text("you have $balance votes remaining",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ));
        });
  }

  Widget _buildCandidateVoteControls(BuildContext c, WidgetRef ref) {
    final candidatesAsync = ref.watch(decisionCandidatesProvider(decisionId));
    // candidatesAsync.whenData((candidates) {
    //   final cstr = candidates.map((c) => c.data()?.title).toString();
    //   debugPrint("candidates: $cstr");
    // });

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
