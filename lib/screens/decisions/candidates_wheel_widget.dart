import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decisionroll/common/candidate_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../common/sizeConfig.dart';
import '../../models/database/candidate_model.dart';
import '../../providers/database/decision_candidates_provider.dart';

class CandidatesWheel extends ConsumerWidget {
  final String decisionId;

  CandidatesWheel(this.decisionId) : super(key: Key(decisionId));

  @override
  Widget build(BuildContext c, WidgetRef ref) {
    final candidatesAsync = ref.watch(decisionCandidatesProvider(decisionId));

    return candidatesAsync.maybeWhen(
        orElse: () => _buildCandidatesWheel(c, []),
        data: (candidates) => _buildCandidatesWheel(c, candidates));
  }

  Widget _buildCandidatesWheel(
      BuildContext c, List<DocumentSnapshot<CandidateModel>> candidates) {
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
  }

  List<ChartCandidate> _buildChartCandidateList(
      List<DocumentSnapshot<CandidateModel>> candidates) {
    final candidateModels = candidates.map((candidateSnapshot) =>
        candidateSnapshot.data() ?? CandidateModel.blank());
    final totalWeight =
        candidateModels.fold<int>(0, (total, c) => total + c.weight);
    return candidateModels.map((candidateModel) {
      final color = CandidateColors.getColorFromIdx(candidateModel.index);
      // if all candidates are zero, display a uniform weight chart
      final weight = totalWeight == 0 ? 1 : candidateModel.weight;
      return ChartCandidate(candidateModel.title, weight, color);
    }).toList();
  }
}

class ChartCandidate {
  ChartCandidate(this.title, this.weight, this.color);
  final String title;
  final int weight;
  final Color color;
}
