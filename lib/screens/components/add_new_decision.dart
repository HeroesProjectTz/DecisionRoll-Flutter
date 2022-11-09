import 'package:decisionroll/providers/database/add_decision_provider.dart';
import 'package:decisionroll/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AddNewDecisionWidget extends ConsumerWidget {
  AddNewDecisionWidget({
    Key? key,
  }) : super(key: key);

  final TextEditingController titleController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: TextField(
            controller: titleController,
            decoration: const InputDecoration(
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.all(15),
              fillColor: Colors.white,
              filled: true,
              hintText: "Enter your title to create new roll",
              hintStyle: TextStyle(
                color: Color(0xff545454),
              ),
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            onTap: () {
              if (titleController.text != '') {
                ref.read(addDecisionProvider(titleController.text)).when(
                      data: (decision) {
                        titleController.clear();
                        // goRouter.go('/decision/${decision.id}');
                      },
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (e, st) => Center(child: Text(e.toString())),
                    );
              }
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
}
