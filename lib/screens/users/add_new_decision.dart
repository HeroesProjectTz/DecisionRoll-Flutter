import 'package:decisionroll/providers/database/database_provider.dart';
import 'package:decisionroll/utilities/colors.dart';
import 'package:decisionroll/common/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddNewDecisionWidget extends ConsumerWidget {
  AddNewDecisionWidget({
    Key? key,
  }) : super(key: key);

  final TextEditingController titleController = TextEditingController();
  @override
  Widget build(BuildContext c, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: TextField(
            onSubmitted: (value) {
              _newDecisionOnSubmit(c, ref);
            },
            controller: titleController,
            decoration: const InputDecoration(
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.all(15),
              fillColor: Colors.white,
              filled: true,
              hintText: "New Decision title",
              hintStyle: TextStyle(
                color: Color(0xff545454),
              ),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              _newDecisionOnSubmit(c, ref);
            },
            child: Container(
              decoration: const BoxDecoration(color: blueColor05),
              padding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 12.8),
              child: const Center(
                child: Text(
                  "Create",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _newDecisionOnSubmit(BuildContext c, WidgetRef ref) {
    if (titleController.text != '') {
      ref.read(databaseProvider).whenData((db) async {
        if (db != null) {
          final decision = await db.addDecisionByTitle(titleController.text);
          debugPrint("added Decision ${decision.id}");
          goRouter
              .goNamed('decisionDetails', params: {'decisionid': decision.id});
        } else {
          debugPrint("FirestoreDatabase was null");
        }
        titleController.clear();
      });
    }
  }
}
