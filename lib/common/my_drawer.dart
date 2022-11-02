import 'package:decisionroll/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            onTap: () => GoRouter.of(context).go('/homepage'),
            child: const ListTile(
              leading: Icon(
                FontAwesomeIcons.diceFour,
                color: blueColor,
              ),
              title: Text('Homepage'),
            ),
          ),
          InkWell(
            onTap: () => GoRouter.of(context).go('/user/1/decisions'),
            child: const ListTile(
              leading: Icon(
                FontAwesomeIcons.dice,
                color: blueColor,
              ),
              title: Text('My Decisions'),
            ),
          ),
          InkWell(
            onTap: () => GoRouter.of(context).go('/account'),
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
