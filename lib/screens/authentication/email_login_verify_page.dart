import 'dart:convert';

import 'package:decisionroll/common/bubble_loading_widget.dart';
import 'package:decisionroll/providers/authentication/email_link_verification.dart';
import 'package:decisionroll/screens/homescreen/homescreen_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:decisionroll/common/sizeConfig.dart';
import 'package:decisionroll/utilities/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpVerifyPage extends ConsumerStatefulWidget {
  final String email;
  const SignUpVerifyPage({required this.email, Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SignUpVerifyPageState();
}

class _SignUpVerifyPageState extends ConsumerState<SignUpVerifyPage> {
  @override
  Widget build(BuildContext context) {
    final response = ref.watch(emailLoginVerificationProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 25, left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Email Login Verification",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: SizeConfig.screenHeight! * 0.08,
                ),
                const Text("We have sent a login link to ",
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                Text(widget.email,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: blueColor)),
                SizedBox(
                  height: SizeConfig.screenHeight! * 0.03,
                ),
                const Text(
                    "Click the link from the email we sent, and comeback to your app and you will be verified successfuly. \nRemember not to remove your app from background.",
                    style:
                        TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                SizedBox(
                  height: SizeConfig.screenHeight! * 0.2,
                ),
                response.maybeWhen(
                    orElse: () => const SizedBox(),
                    data: (data) {
                      // print("DATA IS: $data");
                      var modeledJson = json.decode(response.value.toString());
                      // Save User Access Token To Device
                      saveUserDetails() async {
                        SharedPreferences sharedPreferences =
                            await SharedPreferences.getInstance();
                        sharedPreferences.setBool('logged', true);
                        sharedPreferences.setString(
                            'user_id', modeledJson['user_id']);
                        sharedPreferences.setString(
                            'user_email', modeledJson['user_email']);
                        sharedPreferences.setString(
                            'token', modeledJson['token']);
                      }

                      if (modeledJson['status'] == 'success') {
                        saveUserDetails();
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const HomeScreenPage(
                                    child: SizedBox(),
                                  )));
                        });
                      }
                      return const SizedBox();
                    }),
                const BubbleLoadingWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
