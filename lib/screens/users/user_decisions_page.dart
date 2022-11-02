import 'package:decisionroll/common/my_appbar.dart';
import 'package:decisionroll/common/my_drawer.dart';
import 'package:decisionroll/utilities/colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UserDecisionsPage extends StatelessWidget {
  String userId;
  UserDecisionsPage({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteBackgroundColor,
        appBar: const MyAppBar(),
        drawer: MyDrawer(),
        body: Center(child: Text("User $userId Decisions Page")));
  }
}
