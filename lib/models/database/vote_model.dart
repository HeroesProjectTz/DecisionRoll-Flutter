import 'package:cloud_firestore/cloud_firestore.dart';

class VoteModel {
  final int weight;

  const VoteModel({this.weight = 0});

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
