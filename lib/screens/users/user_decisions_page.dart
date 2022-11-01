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
    return Scaffold(body: Center(child: Text("User $userId Decisions Page")));
  }
}
