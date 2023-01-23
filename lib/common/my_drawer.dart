import 'package:decisionroll/common/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:decisionroll/providers/authentication/authentication_provider.dart';
import 'package:decisionroll/utilities/colors.dart';

class MyDrawer extends ConsumerWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: blueColor,
            ),
            child: Text(
              'DecisionRoll',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          InkWell(
            onTap: () => goRouter.goNamed('homepage'),
            child: const ListTile(
              leading: Icon(
                FontAwesomeIcons.diceFour,
                color: blueColor,
              ),
              title: Text('Homepage'),
            ),
          ),
          InkWell(
            onTap: () => goRouter.goNamed('userDecisions', params: {
              'uid': ref.read(authenticationProvider).getCurrentUserUID()
            }),
            child: const ListTile(
              leading: Icon(
                FontAwesomeIcons.dice,
                color: blueColor,
              ),
              title: Text('My Decisions'),
            ),
          ),
          InkWell(
            onTap: () => goRouter.goNamed('account'),
            child: const ListTile(
              leading: Icon(
                FontAwesomeIcons.user,
                color: blueColor,
              ),
              title: Text('Account'),
            ),
          ),
        ],
      ),
    );
  }
}
