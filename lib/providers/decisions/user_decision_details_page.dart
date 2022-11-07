import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:decisionroll/models/decisions/decision_model.dart';

class UserDecisionDetailsPage extends ConsumerWidget {
  DecisionModel decisionModel;
  UserDecisionDetailsPage({
    Key? key,
    required this.decisionModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: Center(
            child: Text(
      decisionModel.title,
      style: const TextStyle(
        color: Colors.black,
      ),
    )));
  }
}
