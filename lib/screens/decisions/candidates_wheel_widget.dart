import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decisionroll/common/candidate_colors.dart';
import 'package:decisionroll/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../common/my_appbar.dart';
import '../../common/routes.dart';
import '../../common/sizeConfig.dart';
import '../../models/database/candidate_model.dart';
import '../../models/database/decision_model.dart';
import '../../providers/database/database_provider.dart';
import '../../providers/database/decision_candidates_provider.dart';
import '../../providers/database/decision_provider.dart';

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
    return candidates.map((candidateSnapshot) {
      final candidateModel = candidateSnapshot.data() ?? CandidateModel.blank();
      final color = CandidateColors.getColorFromIdx(candidateModel.index);
      return ChartCandidate(candidateModel.title, candidateModel.weight, color);
    }).toList();
  }
}

class ChartCandidate {
  ChartCandidate(this.title, this.weight, this.color);
  final String title;
  final int weight;
  final Color color;
}
