import 'package:decisionroll/common/my_appbar.dart';
import 'package:decisionroll/common/my_drawer.dart';
import 'package:decisionroll/providers/authentication/authentication_provider.dart';
import 'package:decisionroll/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    debugPrint("homepage loaded");
    return Scaffold(
      backgroundColor: whiteBackgroundColor,
      appBar: MyAppBar(),
      drawer: MyDrawer(),
      body: const Center(
        child: Text(
          "Homepage ",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
