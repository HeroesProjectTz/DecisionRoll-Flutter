import 'package:decisionroll/providers/database/database_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/authentication/authentication_provider.dart';
import 'login_page.dart';
import 'package:decisionroll/services/firestore_database.dart';

class CheckAuth extends ConsumerWidget {
  final Widget Function(FirestoreDatabase db) pageBuilder;

  const CheckAuth({
    Key? key,
    required this.pageBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext c, WidgetRef ref) {
    final dbAsync = ref.watch(databaseProvider);
    return dbAsync.maybeWhen(
        orElse: () => const LoginPage(),
        data: (db) {
          if (db != null) {
            return pageBuilder(db);
          } else {
            return const LoginPage();
          }
        });
  }
}
