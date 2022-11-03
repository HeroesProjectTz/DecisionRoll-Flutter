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
    return Scaffold(
      backgroundColor: whiteBackgroundColor,
      appBar: const MyAppBar(),
      drawer: MyDrawer(),
      body: Center(
        child: Text(
          "Homepage + ${ref.read(authenticationProvider).getCurrentUserFullName()}",
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
