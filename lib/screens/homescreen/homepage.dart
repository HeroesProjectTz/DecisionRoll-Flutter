import 'dart:convert';

import 'package:decisionroll/common/sizeConfig.dart';
import 'package:decisionroll/models/decisions/decisions_list_model.dart';
import 'package:decisionroll/providers/decisions/list_decisions/list_decisions_provider.dart';
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
    final TextEditingController messageController = TextEditingController();
    final decisions = ref.watch(fetchDecisionsProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: SizeConfig.screenHeight! * 0.5,
              child: decisions.when(
                data: (data) {
                  List decodedList = [];
                  var modeledJson = json.decode(data.toString());
                  decodedList.addAll(modeledJson);

                  return ListView.builder(
                      itemCount: decodedList.length,
                      itemBuilder: (context, index) {
                        DecisionsListModel decisionsListModel =
                            DecisionsListModel.fromJson(modeledJson[index]);

                        return Text(decisionsListModel.title.toString());
                      });
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (_, __) => const Text(
                    'Probably server not running, run "yarn start" under the server folder!'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
