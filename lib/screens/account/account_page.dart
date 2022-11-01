import 'package:decisionroll/common/option_view.dart';
import 'package:decisionroll/common/sizeConfig.dart';
import 'package:decisionroll/providers/authentication/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../utilities/colors.dart';

class AccountPage extends ConsumerWidget {
  const AccountPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: Center(
      child: InkWell(
        onTap: () {
          ref
              .read(authenticationProvider)
              .signOut()
              .whenComplete(() => GoRouter.of(context).go('/authwrapper'));
        },
        child: SizedBox(
            width: SizeConfig.screenWidth,
            child: OptionView(
              blueColor,
              'SignOut',
              padding: 15,
            )),
      ),
    ));
  }
}
