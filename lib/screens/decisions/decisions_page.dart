import 'package:flutter/material.dart';

class DecisionPage extends StatelessWidget {
  String userId;
  DecisionPage({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("User $userId Decisions Page")));
  }
}
