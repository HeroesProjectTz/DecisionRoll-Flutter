import 'package:decisionroll/common/sizeConfig.dart';
import 'package:decisionroll/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  void initState() {
    // ref.read(fetchDecisionsProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData('werewolf', 25, 3, const Color.fromRGBO(9, 0, 136, 1)),
      ChartData('charades', 38, 4, const Color.fromRGBO(147, 0, 119, 1)),
      ChartData('burrito', 34, 3, const Color.fromRGBO(228, 0, 124, 1)),
      ChartData('hike', 52, 0, const Color.fromRGBO(255, 189, 57, 1))
    ];
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: SizeConfig.screenHeight! * 0.05),
        const Text("let's roll!",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            )),
        SizedBox(height: SizeConfig.screenHeight! * 0.01),
        const Text("you have 4 votes remaining",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            )),
        Expanded(
            child: SfCircularChart(series: <CircularSeries>[
          // Renders doughnut chart
          DoughnutSeries<ChartData, String>(
              dataSource: chartData,
              dataLabelSettings: const DataLabelSettings(
                  isVisible: true, textStyle: TextStyle(fontSize: 12)),
              dataLabelMapper: (datum, index) {
                return '${datum.title}  '
                    ' \n my votes: ${datum.myVotes} \n total: ${datum.totalVotes}';
              },
              pointColorMapper: (ChartData data, _) => data.color,
              xValueMapper: (ChartData data, _) => data.title,
              yValueMapper: (ChartData data, _) => data.totalVotes)
        ])),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            // vertical: 8,
          ),
          height: SizeConfig.screenHeight! * 0.35,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (context, index) => Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: blueColor,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 15,
                        backgroundColor: blueColor04,
                        child: Icon(FontAwesomeIcons.plus,
                            color: Colors.white, size: 15),
                      ),
                      SizedBox(width: SizeConfig.screenWidth! * 0.03),
                      const CircleAvatar(
                          radius: 17,
                          backgroundColor: whiteBackgroundColor,
                          child: Text('4',
                              style: TextStyle(
                                color: blueColor04,
                                fontWeight: FontWeight.bold,
                              ))),
                      SizedBox(width: SizeConfig.screenWidth! * 0.03),
                      const CircleAvatar(
                        radius: 15,
                        backgroundColor: blueColor04,
                        child: Icon(FontAwesomeIcons.minus,
                            color: Colors.white, size: 15),
                      ),
                    ],
                  ),
                  const Text('werewolf',
                      style: TextStyle(
                        color: whiteBackgroundColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      )),
                  SizedBox(width: SizeConfig.screenWidth! * 0.03),
                ],
              ),
            ),
          ),
        )
      ],
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
