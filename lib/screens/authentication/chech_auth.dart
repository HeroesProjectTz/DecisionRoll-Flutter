import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/authentication/authentication_provider.dart';
import 'login_page.dart';

class CheckAuth extends ConsumerWidget {
  final Widget page;

  const CheckAuth({
    Key? key,
    required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext c, WidgetRef ref) {
    final auth = ref.watch(authStateChangesProvider);
    return auth.maybeWhen(
        orElse: () => const LoginPage(),
        data: (user) {
          if (user != null) {
            return page;
          } else {
            return const LoginPage();
          }
        });
  }
}
