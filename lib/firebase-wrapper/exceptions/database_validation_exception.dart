class DatabaseValidationException implements Exception {
  String cause;
  DatabaseValidationException(this.cause);
}