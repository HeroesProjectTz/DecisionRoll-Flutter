import 'package:decisionroll/models/authentication/authentication_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Access the Authentication class
final authenticationProvider = Provider<Authentication>((ref) {
  return Authentication();
});

// Stream Authentication State once from authenticationProvider
final authStateProvider = StreamProvider<User?>((ref) {
  return ref.read(authenticationProvider).authStateChange;
});
