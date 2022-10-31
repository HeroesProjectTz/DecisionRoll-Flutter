import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  String userId;
  ProfilePage({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("User $userId Profile Page")));
  }
}
