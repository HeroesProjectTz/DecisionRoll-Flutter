import 'package:decisionroll/main.dart';
import 'package:decisionroll/screens/account/account_page.dart';
import 'package:decisionroll/screens/authentication/login_page.dart';
import 'package:decisionroll/screens/authentication/sign_up_page.dart';
import 'package:decisionroll/screens/decisions/decision_page.dart';
import 'package:decisionroll/screens/decisions/qr_code_scanner.dart';
import 'package:decisionroll/screens/home/homepage.dart';
import 'package:decisionroll/screens/users/user_decisions_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();

final goRouter = GoRouter(
  initialLocation: '/authwrapper',
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/signin',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignUpPage(),
    ),
    GoRoute(
      path: '/authwrapper',
      builder: (context, state) => const AuthenticationWrapper(),
    ),
    GoRoute(
      path: '/decision/:decisionid/qr',
      builder: (context, state) {
        final decisionId = state.params['decisionid'];
        if (decisionId != null) {
          return QrCodeView(decisionId: decisionId.toString());
        } else {
          throw ("missing decisionId param");
        }
      },
    ),
    GoRoute(
      path: '/decision/:decisionid',
      builder: (context, state) {
        if (FirebaseAuth.instance.currentUser == null) {
          return const LoginPage();
        } else {
          final decisionId = state.params['decisionid'];

          if (decisionId != null) {
            return DecisionPage(decisionId: decisionId);
          } else {
            throw ("missing decisionId param");
          }
        }
      },
    ),
    GoRoute(
        path: '/homepage',
        builder: (context, state) {
          if (FirebaseAuth.instance.currentUser == null) {
            return const LoginPage();
          } else {
            return const HomePage();
          }
        }),
    GoRoute(
        path: '/user/:uid/decisions',
        builder: (context, state) {
          if (FirebaseAuth.instance.currentUser == null) {
            return const LoginPage();
          } else {
            final userId = state.params['uid'];

            if (userId != null) {
              return UserDecisionsPage(userId: userId);
            } else {
              throw ("missing userId param");
            }
          }
        }),
    GoRoute(
        path: '/account',
        builder: (context, state) {
          if (FirebaseAuth.instance.currentUser == null) {
            return const LoginPage();
          }
          // final id = state.params['id'];
          else {
            return const AccountPage(
                // userId: id.toString(),
                );
          }
        }),
  ],
);
