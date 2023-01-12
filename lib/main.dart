import 'dart:async';
import 'package:decisionroll/common/bubble_loading_widget.dart';
import 'package:decisionroll/common/routes.dart';
import 'package:decisionroll/providers/authentication/authentication_provider.dart';
import 'package:decisionroll/utilities/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uni_links/uni_links.dart';

// test
//
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

String savedUserId = "";
String savedToken = "";
String savedUserEmail = "";
bool loggedIn = true;

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  Uri? _initialURI;
  Uri? _currentURI;
  Object? _err;
  bool _initialURILinkHandled = false;

  StreamSubscription? _streamSubscription;

  @override
  void initState() {
    super.initState();
    _initURIHandler();
    _incomingLinkHandler();
  }

  Future<void> _initURIHandler() async {
    if (!_initialURILinkHandled) {
      _initialURILinkHandled = true;
      debugPrint('Invoked _initURIHandler');

      try {
        final initialURI = await getInitialUri();
        // Use the initialURI and warn the user if it is not correct,
        // but keep in mind it could be `null`.
        if (initialURI != null) {
          debugPrint("Initial URI received $initialURI");
          if (!mounted) {
            return;
          }
          setState(() {
            _initialURI = initialURI;
          });
        } else {
          debugPrint("Null Initial URI received");
        }
      } on PlatformException {
        // Platform messages may fail, so we use a try/catch PlatformException.
        // Handle exception by warning the user their action did not succeed
        debugPrint("Failed to receive initial uri");
      } on FormatException catch (err) {
        if (!mounted) {
          return;
        }
        debugPrint('Malformed Initial URI received');
        setState(() => _err = err);
      }
    }
  }

  /// Handle incoming links - the ones that the app will receive from the OS
  /// while already started.
  void _incomingLinkHandler() {
    if (!kIsWeb) {
      // It will handle app links while the app is already started - be it in
      // the foreground or in the background.
      _streamSubscription = uriLinkStream.listen((Uri? uri) {
        if (!mounted) {
          return;
        }
        debugPrint('Received URI: $uri');
        setState(() {
          _currentURI = uri;
          _err = null;
        });
      }, onError: (Object err) {
        if (!mounted) {
          return;
        }
        debugPrint('Error occurred: $err');
        setState(() {
          _currentURI = null;
          if (err is FormatException) {
            _err = err;
          } else {
            _err = null;
          }
        });
      });
    }
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

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

class AuthenticationWrapper extends ConsumerWidget {
  const AuthenticationWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateChangesProvider);
    return authState.when(
        data: (data) {
          if (data != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              goRouter.go('/user/${data.uid}/decisions');
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
