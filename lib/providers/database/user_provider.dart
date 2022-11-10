import 'package:decisionroll/providers/database/database_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/database/user_model.dart';

final userProvider =
    StreamProvider.autoDispose.family<UserModel, String>((ref, userId) async* {
  final db = await ref.watch(databaseProvider.future);
  if (db != null) {
    yield* db.getUser(userId).snapshots().map((doc) {
      final user = doc.data();
      return user ?? UserModel.blank();
    });
  }
});
