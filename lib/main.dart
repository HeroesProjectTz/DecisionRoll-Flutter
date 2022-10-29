import 'dart:async';

import 'package:decisionroll/common/bubble_loading_widget.dart';
import 'package:decisionroll/common/sizeConfig.dart';
import 'package:decisionroll/screens/authentication/login_page.dart';
import 'package:decisionroll/screens/homescreen/homescreen_page.dart';
import 'package:decisionroll/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: const AuthenticationWrapper(),
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
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreenPage()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        }
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
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
