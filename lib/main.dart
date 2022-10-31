import 'dart:async';

import 'package:decisionroll/common/bubble_loading_widget.dart';
import 'package:decisionroll/common/sizeConfig.dart';
import 'package:decisionroll/screens/decisions/decisions_page.dart';
import 'package:decisionroll/screens/decisions/profile_page.dart';
import 'package:decisionroll/screens/homescreen/homepage.dart';
import 'package:decisionroll/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

void main() {
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

// final GoRouter goRouter =
//     GoRouter(
//         navigatorKey: _rootNavigatorKey,
//       debugLogDiagnostics: true, initialLocation: '/homepage', routes: [
//   ShellRoute(
//           navigatorKey: _shellNavigatorKey,
//     builder: (context, state, child) {
//       return HomeScreenPage(child: child);
//     },
//     routes: <RouteBase>[
// GoRoute(
//   path: '/home',
// builder: (context, state, child) {
//   return ScaffoldWithBottomNavBar(child: child);
// },
// ),
//       GoRoute(
//         path: '/',
//         builder: (context, state) => const AuthenticationWrapper(),
//         routes: [
//           GoRoute(
//             path: 'auth',
//             builder: (context, state) => const LoginPage(),
//           ),
//           GoRoute(
//             path: 'decisions',
//             builder: (context, state) => const DecisionPage(),
//           ),
//           GoRoute(
//             path: 'profile',
//             builder: (context, state) => const ProfilePage(),
//           ),
//         ],
//       ),
//     ],
//   ),
// ]);
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
    initialLocation: '/decisions/1',
    icon: Icon(
      FontAwesomeIcons.dice,
      color: blueColor,
    ),
    label: 'Decisions',
  ),
  const ScaffoldWithNavBarTabItem(
    initialLocation: '/profile/1',
    icon: Icon(
      FontAwesomeIcons.user,
      color: blueColor,
    ),
    label: 'Profile',
  ),
];

final goRouter = GoRouter(
  initialLocation: '/homepage',
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  routes: [
    // GoRoute(
    //   path: 'auth',
    //   builder: (context, state) => const LoginPage(),
    // ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        SizeConfig(context);

        return ScaffoldWithBottomNavBar(tabs: tabs, child: child);
      },
      routes: [
        // Products
        GoRoute(
            path: '/homepage', builder: (context, state) => const HomePage()),
        // Shopping Cart
        GoRoute(
            path: '/decisions/:id',
            builder: (context, state) {
              final id = state.params['id'];
              return DecisionPage(
                userId: id.toString(),
              );
            }),

        GoRoute(
            path: '/profile/:id',
            builder: (context, state) {
              final id = state.params['id'];
              return ProfilePage(
                userId: id.toString(),
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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

class AuthenticationWrapper extends StatefulWidget {
  const AuthenticationWrapper({Key? key}) : super(key: key);

  @override
  State<AuthenticationWrapper> createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  void startTimer() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool? logged = preferences.getBool("logged");
    // preferences.clear();
    Timer(const Duration(milliseconds: 2000), () {
      if (preferences.getBool("logged") != null) {
        logged = preferences.getBool("logged");

        var userId = preferences.getString("user_id")!;
        var token = preferences.getString("token")!;
        var userEmail = preferences.getString("user_email")!;
        if (logged == true) {
          savedUserId = userId;
          savedToken = token;
          savedUserEmail = userEmail;
          context.go('/home');
        } else {
          context.go('/auth');
        }
      } else {
        context.go('/auth');
      }
    });
  }

  @override
  void initState() {
    startTimer();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig(context);
    return const Scaffold(body: BubbleLoadingWidget());
  }
}
