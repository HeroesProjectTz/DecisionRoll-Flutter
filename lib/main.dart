import 'dart:async';

import 'package:decisionroll/common/bubble_loading_widget.dart';
import 'package:decisionroll/common/sizeConfig.dart';
import 'package:decisionroll/providers/authentication/authentication_provider.dart';
import 'package:decisionroll/screens/authentication/login_page.dart';
import 'package:decisionroll/screens/authentication/sign_up_page.dart';
import 'package:decisionroll/screens/decisions/user_decisions_page.dart';
import 'package:decisionroll/screens/account/account_page.dart';
import 'package:decisionroll/screens/homescreen/homepage.dart';
import 'package:decisionroll/utilities/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyC1Uppt_Z8H7g5QtsUvQnKtOGJgrRTfDMY",
          appId: "1:678060492134:web:fb123062a8cb06a04b74a7",
          messagingSenderId: "678060492134",
          projectId: "decisionroll",
          authDomain: "decisionroll.firebaseapp.com"),
    );
  }
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

late io.Socket socket;
String savedUserId = "";
String savedToken = "";
String savedUserEmail = "";
bool loggedIn = true;
// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final tabs = [
  const ScaffoldWithNavBarTabItem(
    initialLocation: '/homepage',
    icon: Icon(
      FontAwesomeIcons.diceFour,
      color: blueColor,
    ),
    label: 'Home',
  ),
  const ScaffoldWithNavBarTabItem(
    initialLocation: '/user/1/decisions',
    icon: Icon(
      FontAwesomeIcons.dice,
      color: blueColor,
    ),
    label: 'My Decisions',
  ),
  const ScaffoldWithNavBarTabItem(
    initialLocation: '/account',
    icon: Icon(
      FontAwesomeIcons.user,
      color: blueColor,
    ),
    label: 'Account',
  ),
];

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
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        SizeConfig(context);

        return ScaffoldWithBottomNavBar(tabs: tabs, child: child);
      },
      routes: [
        GoRoute(
            path: '/homepage', builder: (context, state) => const HomePage()),
        GoRoute(
            path: '/user/:uid/decisions',
            builder: (context, state) {
              final userId = state.params['uid'];
              return UserDecisionsPage(
                userId: userId.toString(),
              );
            }),
        GoRoute(
            path: '/account',
            builder: (context, state) {
              // final id = state.params['id'];
              return const AccountPage(
                  // userId: id.toString(),
                  );
            }),
      ],
    ),
  ],
);

/// Representation of a tab item in a [ScaffoldWithNavBar]
class ScaffoldWithNavBarTabItem extends BottomNavigationBarItem {
  /// Constructs an [ScaffoldWithNavBarTabItem].
  const ScaffoldWithNavBarTabItem(
      {required this.initialLocation, required Widget icon, String? label})
      : super(icon: icon, label: label);

  /// The initial location/path
  final String initialLocation;
}

class ScaffoldWithBottomNavBar extends StatefulWidget {
  const ScaffoldWithBottomNavBar(
      {Key? key, required this.child, required this.tabs})
      : super(key: key);
  final Widget child;
  final List<ScaffoldWithNavBarTabItem> tabs;

  @override
  State<ScaffoldWithBottomNavBar> createState() =>
      _ScaffoldWithBottomNavBarState();
}

class _ScaffoldWithBottomNavBarState extends State<ScaffoldWithBottomNavBar> {
  int _locationToTabIndex(String location) {
    final index =
        widget.tabs.indexWhere((t) => location.startsWith(t.initialLocation));
    // if index not found (-1), return 0
    return index < 0 ? 0 : index;
  }

  int get _currentIndex => _locationToTabIndex(GoRouter.of(context).location);

  void _onItemTapped(BuildContext context, int tabIndex) {
    // Only navigate if the tab index has changed
    if (tabIndex != _currentIndex) {
      context.go(widget.tabs[tabIndex].initialLocation);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0.0,
        showUnselectedLabels: false,
        selectedFontSize: 12,
        selectedLabelStyle: const TextStyle(
          color: blueColor,
          fontWeight: FontWeight.w500,
        ),
        backgroundColor: whiteBackgroundColor,
        currentIndex: _currentIndex,
        items: widget.tabs,
        onTap: (index) => _onItemTapped(context, index),
      ),
    );
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routeInformationProvider: goRouter.routeInformationProvider,
      routeInformationParser: goRouter.routeInformationParser,
      routerDelegate: goRouter.routerDelegate,
      debugShowCheckedModeBanner: false,
      title: 'DecisionRoll',
      theme: ThemeData(
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: blueColor,
        ),
        inputDecorationTheme: InputDecorationTheme(
          iconColor: Colors.black,
          enabledBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Color(0xffD9D9D9), width: 0.0),
              borderRadius: BorderRadius.circular(8)),
          focusedBorder: OutlineInputBorder(
              borderSide:
                  const BorderSide(color: Color(0xffD9D9D9), width: 1.0),
              borderRadius: BorderRadius.circular(8)),
          fillColor: const Color(0xffD9D9D9),
          filled: true,
          isDense: true,
          focusColor: const Color(0xffD9D9D9),
          // focusColor: Colors.transparent,
          contentPadding: const EdgeInsets.all(18),
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
    );
  }
}

class AuthenticationWrapper extends ConsumerWidget {
  const AuthenticationWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SizeConfig(context);

    final authState = ref.watch(authStateProvider);
    return authState.when(
        data: (data) {
          if (data != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.go('/homepage');
            });
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.go('/signin');
            });
          }
          return Container(color: Colors.white);
        },
        loading: () => const BubbleLoadingWidget(),
        error: (e, trace) => Text(e.toString()));
  }
}
