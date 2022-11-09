import 'package:decisionroll/utilities/colors.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:decisionroll/models/database/decision_model.dart';
import 'package:decisionroll/models/database/candidate_model.dart';
import 'package:decisionroll/common/candidate_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CandidateAddWidget extends ConsumerWidget {
  final DocumentSnapshot<DecisionModel?> decision;

  CandidateAddWidget(this.decision) : super(key: Key(decision.id));

  Widget build(BuildContext c, WidgetRef ref) {
    return Row(children: [
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
      // CandidateVoteControl(purpleColor),
    ]);
  }
}
