import 'package:decisionroll/models/database/decision_model.dart';
import 'package:decisionroll/models/database/candidate_model.dart';
import 'package:decisionroll/models/database/vote_model.dart';
import 'package:decisionroll/models/database/account_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../models/database/user_model.dart';

class FirestoreDatabase {
  final FirebaseFirestore db;
  final User user;
  late final uid = user.uid;

  FirestoreDatabase({required this.db, required this.user});

  // ==== type-safe collection access helpers ====
  CollectionReference<UserModel> usersCollection() =>
      db.collection('users').withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromSnapshot(snapshot),
          toFirestore: (user, _) => user.toMap());

  CollectionReference<DecisionModel> decisionsCollection() =>
      db.collection('decisions').withConverter<DecisionModel>(
          fromFirestore: (snapshot, _) => DecisionModel.fromSnapshot(snapshot),
          toFirestore: (decision, _) => decision.toMap());

  CollectionReference<CandidateModel> decisionCandidatesCollection(
          String decisionId) =>
      decisionsCollection()
          .doc(decisionId)
          .collection('candidates')
          .withConverter<CandidateModel>(
              fromFirestore: (snapshot, _) =>
                  CandidateModel.fromSnapshot(snapshot),
              toFirestore: (candidate, _) => candidate.toMap());

  CollectionReference<AccountModel> decisionAccountsCollection(
          String decisionId) =>
      decisionsCollection()
          .doc(decisionId)
          .collection('accounts')
          .withConverter<AccountModel>(
              fromFirestore: (snapshot, _) =>
                  AccountModel.fromSnapshot(snapshot),
              toFirestore: (candidate, _) => candidate.toMap());

  CollectionReference<VoteModel> candidateVotesCollection(
          String decisionId, String candidateId) =>
      decisionCandidatesCollection(decisionId)
          .doc(candidateId)
          .collection('votes')
          .withConverter<VoteModel>(
              fromFirestore: (snapshot, _) => VoteModel.fromSnapshot(snapshot),
              toFirestore: (vote, _) => vote.toMap());

  // ==== queries ====
  Stream<List<DocumentSnapshot<DecisionModel>>> userDecisions(String ownerId) {
    final decisionsQuery =
        decisionsCollection().where('ownerId', isEqualTo: ownerId);
    final userDecisionsList = decisionsQuery.snapshots().map((_) => _.docs);
    return userDecisionsList;
  }

  Stream<List<DocumentSnapshot<CandidateModel>>> decisionCandidates(
      String decisionId) {
    final candidatesCollection = decisionCandidatesCollection(decisionId);

    final candidatesListStream =
        candidatesCollection.snapshots().map((_) => _.docs);

    return candidatesListStream;
  }

  // ==== databes get operations ====
  DocumentReference<UserModel> getUser(String userId) {
    return usersCollection().doc(userId);
  }

  DocumentReference<DecisionModel> getDecision(String decisionId) {
    return decisionsCollection().doc(decisionId);
  }

  DocumentReference<CandidateModel> getCandidateForDecision(
      String decisionId, String candidateId) {
    return decisionCandidatesCollection(decisionId).doc(candidateId);
  }

  DocumentReference<AccountModel> getMyAccountForDecision(String decisionId) {
    return decisionAccountsCollection(decisionId).doc(uid);
  }

  DocumentReference<VoteModel> getMyVoteForCandidate(
      String decisionId, String candidateId) {
    return candidateVotesCollection(decisionId, candidateId).doc(uid);
  }

  // ==== database update operations ====
  // Decision creation
  Future<DocumentReference<DecisionModel>> addDecision(DecisionModel decision) {
    return decisionsCollection().add(decision);
  }

  Future<DocumentReference<DecisionModel>> addDecisionByTitle(String title) {
    return addDecision(DecisionModel(ownerId: uid, title: title));
  }

  // Decision state advance
  Future<void> advanceDecisionState(String decisionId) async {
    final decisionRef = getDecision(decisionId);

    db.runTransaction((transaction) async {
      final decisionSnapshot = await transaction.get(decisionRef);
      final decision = decisionSnapshot.data();
      if (decision != null && decision.ownerId == uid) {
        final candidatesSnapshot =
            await decisionCandidatesCollection(decisionId).snapshots().first;
        final candidatesList = candidatesSnapshot.docs;
        final newDecision = decision.advanceState(candidatesList);
        transaction.set(decisionRef, newDecision);
      }
    });
  }

  // Candidate creation
  Future<void> addCandidateByTitle(String decisionId, String title) async {
    final decisionRef = getDecision(decisionId);

    db.runTransaction((transaction) async {
      // check that the decision is allowing voting
      final decisionSnapshot = await transaction.get(decisionRef);
      final decision = decisionSnapshot.data();
      if (decision != null && decision.ownerId == uid) {
        final index = decision.nextIndex;
        final candidate = CandidateModel(title: title, index: index);
        decisionCandidatesCollection(decisionId).add(candidate);
        transaction.update(decisionRef, {'nextIndex': FieldValue.increment(1)});
      }
    });
  }

  // voting
  Future<void> incrementVote(String decisionId, String candidateId) async {
    final decisionRef = getDecision(decisionId);
    final voteRef = getMyVoteForCandidate(decisionId, candidateId);
    final accountRef = getMyAccountForDecision(decisionId);
    final candidateRef = getCandidateForDecision(decisionId, candidateId);

    db.runTransaction((transaction) async {
      // check that the decision is allowing voting
      final decisionSnapshot = await transaction.get(decisionRef);
      final decision = decisionSnapshot.data();
      if (decision != null && decision.state == 'open') {
        // check that the current user has enough account balance to pay for the vote
        final currentAccount = await transaction.get(accountRef);
        final updatedAccountModel =
            (currentAccount.data() ?? const AccountModel()).decrementbalance();
        // debugPrint("updated account: ${updatedAccountModel?.balance}");
        if (updatedAccountModel != null) {
          // check that the vote.weight hasn't exceeded 10
          // (which it never should because of account balance check, but still)
          final currentVote = await transaction.get(voteRef);
          final updatedVoteModel =
              (currentVote.data() ?? const VoteModel()).incrementWeight();
          if (updatedVoteModel != null) {
            // increment vote, decrement account, increment candidate
            transaction.set(voteRef, updatedVoteModel);
            transaction.set(accountRef, updatedAccountModel);
            transaction
                .update(candidateRef, {'weight': FieldValue.increment(1)});
          }
        }
      }
    });
  }

  Future<void> decrementVote(String decisionId, String candidateId) async {
    final decisionRef = getDecision(decisionId);
    final voteRef = getMyVoteForCandidate(decisionId, candidateId);
    final accountRef = getMyAccountForDecision(decisionId);
    final candidateRef = getCandidateForDecision(decisionId, candidateId);

    db.runTransaction((transaction) async {
      // check that the decision is allowing voting
      final decisionSnapshot = await transaction.get(decisionRef);
      final decision = decisionSnapshot.data();
      if (decision != null && decision.state == 'open') {
        // check that the vote.weight is above 0
        final currentVote = await transaction.get(voteRef);
        final updatedVoteModel =
            (currentVote.data() ?? const VoteModel()).decrementWeight();

        // debugPrint("updated vote: ${updatedVoteModel?.weight}");
        if (updatedVoteModel != null) {
          final currentAccount = await transaction.get(accountRef);
          final updatedAccountModel =
              (currentAccount.data() ?? const AccountModel())
                  .incrementbalance();

          // decrement vote, decrement candidate
          transaction.set(voteRef, updatedVoteModel);
          transaction
              .update(candidateRef, {'weight': FieldValue.increment(-1)});
          //  increment account only if balance is less than maximum of 10
          // (this should never happen because of vote floor at 0, but still)
          if (updatedAccountModel != null) {
            transaction.set(accountRef, updatedAccountModel);
          }
        }
      }
    });
  }
}
