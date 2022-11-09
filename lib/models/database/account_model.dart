import 'package:cloud_firestore/cloud_firestore.dart';

class AccountModel {
  final int balance;

  const AccountModel({this.balance = 10});

  AccountModel? incrementbalance() {
    if (balance <= 9) {
      return AccountModel(balance: balance + 1);
    } else {
      return null;
    }
  }

  AccountModel? decrementbalance() {
    if (balance >= 1) {
      return AccountModel(balance: balance - 1);
    } else {
      return null;
    }
  }

  factory AccountModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final map = snapshot.data() ?? {};
    return AccountModel.fromMap(map);
  }

  factory AccountModel.fromMap(Map<String, dynamic> map) => AccountModel(
        balance: map['balance'],
      );

  Map<String, dynamic> toMap() => {
        'balance': balance,
      };
}
