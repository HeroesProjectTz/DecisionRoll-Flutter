import 'package:decisionroll/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/sizeConfig.dart';
import '../../models/database/decision_model.dart';
import '../../providers/database/database_provider.dart';
import '../../providers/database/decision_provider.dart';

class StateTransitionButton extends ConsumerWidget {
  final String decisionId;

  StateTransitionButton(this.decisionId) : super(key: Key(decisionId));

  final TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext c, WidgetRef ref) {
    return _buildStateTransitionButton(c, ref);
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
                style: const TextStyle(
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
    return ref.read(databaseProvider).maybeWhen(
        orElse: () => const SizedBox(),
        loading: () => const SizedBox(),
        data: (db) {
          final decisionAsync = ref.watch(decisionProvider(decisionId));
          return decisionAsync.maybeWhen(
              orElse: () => const SizedBox(),
              loading: () => const SizedBox(),
              data: (decision) {
                if (db != null && decision.ownerId != db.uid) {
                  return const SizedBox();
                }
                return _buildStateTransitionButtonFromDecision(
                    c, ref, decision);
              });
        });
  }
}
