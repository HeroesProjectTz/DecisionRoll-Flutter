import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/bubble_loading_widget.dart';
import '../../providers/database/decision_account_provider.dart';
import '../../providers/database/decision_provider.dart';

class StatusText extends ConsumerWidget {
  final String decisionId;

  StatusText(this.decisionId) : super(key: Key(decisionId));

  final TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext c, WidgetRef ref) {
    return _buildStatusText(c, ref);
  }

  Widget _buildStatusTextFromText(String text) {
    return Text(text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ));
  }

  Widget _buildStatusText(BuildContext c, WidgetRef ref) {
    final decisionAsync = ref.watch(decisionProvider(decisionId));

    return decisionAsync.maybeWhen(
        orElse: () => const SizedBox(),
        loading: () => const SizedBox(),
        data: (decision) {
          switch (decision.state) {
            case 'new':
              return _buildStatusTextFromText("Wait for voting to start.");
            case 'open':
              {
                final accountAsync =
                    ref.watch(decisionAccountProvider(decisionId));
                return accountAsync.maybeWhen(
                    orElse: () => const SizedBox(
                          child: Text("no dataa..."),
                        ),
                    loading: () => const BubbleLoadingWidget(),
                    data: (account) {
                      final balance = account.balance;
                      return _buildStatusTextFromText(
                          "you have $balance votes remaining");
                    });
              }
            case 'closed':
              return _buildStatusTextFromText("Voting has closed.");
            case 'finished':
              {
                if (decision.outcome != null) {
                  return _buildStatusTextFromText(
                      "Outcome: ${decision.outcome}");
                } else {
                  return _buildStatusTextFromText("<outcome missing>");
                }
              }
            default:
              return _buildStatusTextFromText("<invalid state>");
          }
        });
  }
}
