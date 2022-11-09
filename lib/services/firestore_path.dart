class FirestorePath {
  static String users = 'users';
  static String user(String uid) => '$users/$uid';
  static String decisions = 'decisions';
  static String decision(String decisionId) => '$decisions/$decisionId';
  static String candidates(String decisionId) =>
      'decisions/$decisionId/candidates';
  static String candidate(String decisionId, String candidateId) =>
      'decisions/$decisionId/candidates/$candidateId';
}
