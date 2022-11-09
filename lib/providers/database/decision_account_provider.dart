import 'package:decisionroll/providers/database/database_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/database/account_model.dart';

final decisionAccountProvider = StreamProvider.autoDispose
    .family<AccountModel, String>((ref, decisionId) async* {
  final db = await ref.watch(databaseProvider.future);
  if (db != null) {
    yield* db.getMyAccountForDecision(decisionId).snapshots().map((doc) {
      return doc.data() ?? AccountModel.blank();
    });
  }
});
