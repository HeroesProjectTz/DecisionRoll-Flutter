import 'package:decisionroll/common/my_appbar.dart';
import 'package:decisionroll/common/my_drawer.dart';
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
  Widget build(BuildContext c, WidgetRef ref) {
    return Scaffold(
        backgroundColor: whiteBackgroundColor,
        appBar: MyAppBar(),
        drawer: MyDrawer(),
        body: Center(
          child: InkWell(
            onTap: () {
              ref
                  .read(authenticationProvider)
                  .signOut()
                  .whenComplete(() => GoRouter.of(c).go('/authwrapper'));
            },
            child: SizedBox(
                width: SizeConfig.screenWidth(c),
                child: OptionView(
                  blueColor,
                  'SignOut',
                  padding: 15,
                )),
          ),
        ));
  }
}
