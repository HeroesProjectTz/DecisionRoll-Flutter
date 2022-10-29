import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  @override
  void initState() {
    // ref.read(fetchDecisionsProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final decisions = ref.watch(fetchDecisionsProvider);
    return const SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffF1FAEE),
      ),
    );
  }
}
