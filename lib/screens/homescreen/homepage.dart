import 'dart:convert';

import 'package:decisionroll/common/list_decisions_shimmer.dart';
import 'package:decisionroll/common/sizeConfig.dart';
import 'package:decisionroll/providers/decisions/list_decisions/list_decisions_provider.dart';
import 'package:decisionroll/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    ref.read(fetchDecisionsProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final decisions = ref.watch(fetchDecisionsProvider);
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffF1FAEE),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: SizeConfig.screenHeight! * 0.01,
              ),
              const Align(
                alignment: Alignment.topRight,
                child: Text(
                  "Sign In",
                  style: TextStyle(
                    color: blueColor04,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(
                height: SizeConfig.screenHeight! * 0.03,
              ),
              const Text(
                "Decisions",
                style: TextStyle(
                  color: blueColor04,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              SizedBox(
                height: SizeConfig.screenHeight! * 0.05,
              ),
              SizedBox(
                height: SizeConfig.screenHeight! * 0.7,
                child: decisions.when(
                  data: (data) {
                    List decodedList = [];
                    var modeledJson = json.decode(data.toString());
                    decodedList.addAll(modeledJson);

                    return Table(
                      border: const TableBorder(
                          horizontalInside: BorderSide(
                              color: whiteBackgroundColor, width: 10.0)),
                      children: [
                        //This table row is for the table header which is static
                        const TableRow(children: [
                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 3),
                              child: Text(
                                "Decision",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87),
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 3),
                              child: Text(
                                "Created At",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87),
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 3),
                              child: Text(
                                "State",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87),
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 3),
                              child: Text(
                                "Created By",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87),
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 3),
                              child: Text(
                                "Vote",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87),
                              ),
                            ),
                          ),
                        ]),
                        // Using the spread operator to add the remaining table rows which have dynamic data
                        // Be sure to use .asMap().entries.map if you want to access their indexes and objectName.map() if you have no interest in the items index.

                        ...decodedList.asMap().entries.map(
                          (decision) {
                            String formatDate() {
                              String formattedDate = decision.value['createdAt']
                                  .toString()
                                  .substring(7);
                              return formattedDate;
                            }

                            return TableRow(
                                decoration: const BoxDecoration(
                                  color: whiteBackgroundColor,
                                ),
                                children: [
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 7),
                                      child: Text(
                                        decision.value['title'],
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 7),
                                      child: Text(
                                        formatDate(),
                                        style: const TextStyle(
                                            fontSize: 10, color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 3),
                                      child: Text(
                                        decision.value['state'].toString(),
                                        style: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: greyColor),
                                      ),
                                    ),
                                  ),
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 7),
                                      child: Text(
                                        decision.value['username'],
                                        style: const TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500,
                                            color: blueColor),
                                      ),
                                    ),
                                  ),
                                  const Center(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 20, horizontal: 3),
                                      child: Text(
                                        "Vote",
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: greenColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ]);
                          },
                        )
                      ],
                    );
                  },
                  loading: () => const ListDecisionsShimmer(),
                  error: (_, __) => const Text('Probably server not running,'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
