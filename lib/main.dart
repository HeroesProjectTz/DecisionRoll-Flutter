import 'dart:async';

import 'package:decisionroll/common/bubble_loading_widget.dart';
import 'package:decisionroll/common/routes.dart';
import 'package:decisionroll/common/sizeConfig.dart';
import 'package:decisionroll/providers/authentication/authentication_provider.dart';
import 'package:decisionroll/providers/socket/socket_provider.dart';
import 'package:decisionroll/utilities/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

Future<void> main() async {
  // SocketService().initConnection();
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
            ref.read(socketServiceProvider).sessionActivated(
                data.uid, data.email.toString(), data.displayName.toString());
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
