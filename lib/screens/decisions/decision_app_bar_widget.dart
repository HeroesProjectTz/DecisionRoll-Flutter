import 'package:decisionroll/common/candidate_colors.dart';
import 'package:decisionroll/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../common/my_appbar.dart';
import '../../common/routes.dart';
import '../../models/database/decision_model.dart';
import '../../providers/database/database_provider.dart';
import '../../providers/database/decision_provider.dart';

class DecisionAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String decisionId;

  DecisionAppBar(this.decisionId) : super(key: Key(decisionId));

  @override
  Widget build(BuildContext c, WidgetRef ref) {
    final decisionAsync = ref.watch(decisionProvider(decisionId));

    return decisionAsync.maybeWhen(
        orElse: () => _buildAppBarWithTitle("Let's Roll"),
        loading: () => _buildAppBarWithTitle("Let's Roll"),
        data: (decision) => _buildAppBarWithTitle(decision.title));
  }

  MyAppBar _buildAppBarWithTitle(String title) {
    return MyAppBar(
      title: title,
      titlecolor: Colors.white,
      color: blueColor05,
      action: [
        InkWell(
          onTap: () => goRouter.go('/decision/$decisionId/qr'),
          child: QrImage(
            data: "${Uri.base.origin}/#/decision/$decisionId",
            version: QrVersions.auto,
            // size: 200.0,
            // backgroundColor: Colors.black,
            foregroundColor: Colors.black,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
