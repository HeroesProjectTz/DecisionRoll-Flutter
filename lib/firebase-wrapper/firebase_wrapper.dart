library firebase_wrapper;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';

import 'exceptions/database_validation_exception.dart';

part 'models/abstract_model.dart';
part 'models/persisted_model.dart';

Either<DatabaseValidationException,PM> safelyWrapDocumentSnapshot<
  AM extends AbstractModel<AM, PM>, 
  PM extends PersistedModel<AM, PM>>(
    DocumentSnapshot<AM> snapshot) {

  try {
    final maybeModel = snapshot.data();
    if (maybeModel == null){
      throw DatabaseValidationException("attempt to reify document with id ${snapshot.id}, but it was empty");
    }
    final persistedModel = maybeModel._persistWith(snapshot);
    return Either.right(persistedModel);

  } on DatabaseValidationException catch(e) {
    return Either.left(e);
  }
}

Tuple2<List<DatabaseValidationException>, List<PM>> safelyWrapQuerySnapshot<
  AM extends AbstractModel<AM, PM>, 
  PM extends PersistedModel<AM, PM>>(
    QuerySnapshot<AM> qSnapshot) {

  final List<DocumentSnapshot<AM>> snapshotDocs = qSnapshot.docs;
  
  final List<Either<DatabaseValidationException,PM>> wrappedModelEitherList = snapshotDocs.map<Either<DatabaseValidationException,PM>>(safelyWrapDocumentSnapshot).toList();
  return Either.partitionEithers(wrappedModelEitherList);
}

List<PM> wrapQuerySnapshot<
  AM extends AbstractModel<AM, PM>, 
  PM extends PersistedModel<AM, PM>>(
    QuerySnapshot<AM> qSnapshot) {
      final safeResults = safelyWrapQuerySnapshot<AM, PM>(qSnapshot);
      // Log the validation errors encountered in the query results
      safeResults.first.map((e) => debugPrint(e.cause));
      // return only the results that passed validation
      return safeResults.second;
    }