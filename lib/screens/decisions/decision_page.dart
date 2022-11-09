import 'package:decisionroll/screens/components/candidate_vote_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:decisionroll/common/my_appbar.dart';
import 'package:decisionroll/common/my_drawer.dart';
import 'package:decisionroll/common/sizeConfig.dart';
import 'package:decisionroll/utilities/colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DecisionPage extends ConsumerWidget {
  final String decisionId;

  DecisionPage({
    Key? key,
    required this.decisionId,
  }) : super(key: key);

  final List<ChartData> chartData = [
    ChartData('werewolf', 25, 3, const Color.fromRGBO(9, 0, 136, 1)),
    ChartData('charades', 38, 4, const Color.fromRGBO(147, 0, 119, 1)),
    ChartData('burrito', 34, 3, const Color.fromRGBO(228, 0, 124, 1)),
    ChartData('hike', 52, 0, const Color.fromRGBO(255, 189, 57, 1))
  ];
  @override
  Widget build(BuildContext c, WidgetRef ref) {
    // debugPrint("decision page: $decisionId");
    // final candidatesAsync = ref.watch(decisionCandidatesProvider(decisionId));
    // candidatesAsync.whenOrNull(
    //   data: (candidates) {
    //     final cstr = candidates.map((c) => c.data()?.title).toString();
    //     debugPrint("candidates: $cstr");
    //   },
    // );

    return Scaffold(
        backgroundColor: purpleColor,
        appBar: const MyAppBar(
          title: 'Roll',
          titlecolor: Colors.white,
          color: blueColor05,
        ),
        drawer: const MyDrawer(),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 15.0,
            horizontal: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text("you have 4 votes remaining",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    )),
              ),
              Expanded(
                  child: SfCircularChart(series: <CircularSeries>[
                // Renders doughnut chart
                DoughnutSeries<ChartData, String>(
                    animationDuration: 0,
                    animationDelay: 0,
                    dataSource: chartData,
                    dataLabelSettings: const DataLabelSettings(
                        isVisible: true, textStyle: TextStyle(fontSize: 12)),
                    dataLabelMapper: (datum, index) {
                      return '${datum.totalVotes}';
                    },
                    pointColorMapper: (ChartData data, _) => data.color,
                    xValueMapper: (ChartData data, _) => data.title,
                    yValueMapper: (ChartData data, _) => data.totalVotes)
              ])),
              SizedBox(height: SizeConfig.screenHeight(c) * 0.1),
              Row(
                children: [
                  const Expanded(
                    flex: 3,
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.all(15),
                        fillColor: Colors.white,
                        filled: true,
                        hintText: "Enter option 1",
                        hintStyle: TextStyle(
                          color: Color(0xff545454),
                        ),
                      ),
                    ),
                  ),
                  CandidateVoteControl(purpleColor),
                ],
              ),
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
}

class ChartData {
  ChartData(this.title, this.totalVotes, this.myVotes, [this.color]);
  final String title;
  final int myVotes;
  final int totalVotes;
  final Color? color;
}
