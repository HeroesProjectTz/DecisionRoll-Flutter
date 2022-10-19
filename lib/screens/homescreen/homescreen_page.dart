import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreenPage extends ConsumerStatefulWidget {
  const HomeScreenPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends ConsumerState<HomeScreenPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
