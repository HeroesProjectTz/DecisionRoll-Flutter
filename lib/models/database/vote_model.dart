import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class VoteModel {
  final int weight;

  const VoteModel({this.weight = 0});

  VoteModel? incrementWeight() {
    if (weight <= 9) {
      return VoteModel(weight: weight + 1);
    } else {
      return null;
    }
  }

  VoteModel? decrementWeight() {
    if (weight >= 1) {
      return VoteModel(weight: weight - 1);
    } else {
      return null;
    }
  }

  factory VoteModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final map = snapshot.data() ?? {};
    return VoteModel.fromMap(map);
  }

  factory VoteModel.fromMap(Map<String, dynamic> map) => VoteModel(
        weight: map['weight'],
      );

  Map<String, dynamic> toMap() => {
        'weight': weight,
      };
}
