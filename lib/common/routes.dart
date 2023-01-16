import 'package:decisionroll/main.dart';
import 'package:decisionroll/screens/account/account_page.dart';
import 'package:decisionroll/screens/authentication/login_page.dart';
import 'package:decisionroll/screens/authentication/sign_up_page.dart';
import 'package:decisionroll/screens/decisions/decision_page.dart';
import 'package:decisionroll/screens/decisions/qr_code_scanner.dart';
import 'package:decisionroll/screens/home/homepage.dart';
import 'package:decisionroll/screens/users/user_decisions_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/authentication/check_auth.dart';

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();

final goRouter = GoRouter(
  initialLocation: '/authwrapper',
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      name: 'signin',
      path: '/signin',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      name: 'signup',
      path: '/signup',
      builder: (context, state) => const SignUpPage(),
    ),
    GoRoute(
      name: 'authWrapper',
      path: '/authwrapper',
      builder: (context, state) => const AuthenticationWrapper(),
    ),
    GoRoute(
      name: 'decisionQR',
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
      name: 'decisionDetails',
      path: '/decision/:decisionid',
      builder: (context, state) {
        final decisionId = state.params['decisionid'];

        if (decisionId != null) {
          return CheckAuth(
              pageBuilder: (db) => DecisionPage(decisionId: decisionId));
        } else {
          throw ("missing decisionId param");
        }
      },
    ),
    GoRoute(
        name: 'homepage',
        path: '/homepage',
        builder: (context, state) {
          return CheckAuth(pageBuilder: (db) => const HomePage());
        }),
    GoRoute(
        name: 'userDecisions',
        path: '/user/:uid/decisions',
        builder: (context, state) {
          final userId = state.params['uid'];

          if (userId != null) {
            return CheckAuth(
                pageBuilder: (db) => UserDecisionsPage(userId: userId));
          } else {
            throw ("missing userId param");
          }
        }),
    GoRoute(
        name: 'account',
        path: '/account',
        builder: (context, state) {
          return CheckAuth(pageBuilder: (db) => const AccountPage());
        })
  ],
);
