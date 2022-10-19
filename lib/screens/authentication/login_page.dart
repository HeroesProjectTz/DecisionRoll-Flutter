import 'package:decisionroll/common/option_view.dart';
import 'package:decisionroll/common/sizeConfig.dart';
import 'package:decisionroll/common/textfield_widget.dart';
import 'package:decisionroll/screens/homescreen/homescreen_page.dart';
import 'package:decisionroll/utilities/colors.dart';
import 'package:decisionroll/utilities/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF1FAEE),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 15,
          ),
          child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                SizedBox(
                  height: SizeConfig.screenHeight! * 0.04,
                ),
                const Text(
                  "Decision Roll",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight! * 0.1,
                ),
                TextFieldWidget(
                    texttFieldController: emailController,
                    hintText: 'Enter your email'),
                SizedBox(
                  height: SizeConfig.screenHeight! * 0.03,
                ),
                InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HomeScreenPage())),
                  child: SizedBox(
                      width: SizeConfig.screenWidth,
                      child: OptionView(
                        blueColor,
                        'SignIn',
                        padding: 15,
                      )),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight! * 0.3,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffD9D9D9),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 15,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        googleIcon,
                        height: SizeConfig.screenHeight! * 0.03,
                      ),
                      SizedBox(
                        width: SizeConfig.screenWidth! * 0.1,
                      ),
                      const Text('SignIn  With Google',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight! * 0.05,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffD9D9D9),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 15,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        facebookIcon,
                        height: SizeConfig.screenHeight! * 0.03,
                      ),
                      SizedBox(
                        width: SizeConfig.screenWidth! * 0.1,
                      ),
                      const Text('SignIn  With Facebook',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ))
                    ],
                  ),
                ),
              ])),
        ));
  }
}
