import 'package:decisionroll/common/option_view.dart';
import 'package:decisionroll/common/sizeConfig.dart';
import 'package:decisionroll/common/textfield_widget.dart';
import 'package:decisionroll/providers/authentication/authentication_provider.dart';
import 'package:decisionroll/utilities/colors.dart';
import 'package:decisionroll/utilities/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController comfirmPasswordController =
      TextEditingController();
  bool isLoading = false;
  bool obscureText = true;
  @override
  Widget build(BuildContext c) {
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
                  height: SizeConfig.screenHeight(c) * 0.04,
                ),
                const Text(
                  "Decision Roll",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight(c) * 0.02,
                ),
                const Text(
                  "Create an account!",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight(c) * 0.04,
                ),
                TextFieldWidget(
                    texttFieldController: fullNameController,
                    hintText: 'Enter your full name'),
                SizedBox(
                  height: SizeConfig.screenHeight(c) * 0.05,
                ),
                TextFieldWidget(
                    texttFieldController: emailController,
                    isEmail: true,
                    hintText: 'Enter your email'),
                SizedBox(
                  height: SizeConfig.screenHeight(c) * 0.05,
                ),
                TextFieldWidget(
                    obscureText: obscureText,
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                      child: Icon(
                        obscureText == true
                            ? FontAwesomeIcons.eyeSlash
                            : FontAwesomeIcons.eye,
                        color: Colors.black,
                      ),
                    ),
                    texttFieldController: passwordController,
                    hintText: 'password'),
                SizedBox(
                  height: SizeConfig.screenHeight(c) * 0.05,
                ),
                TextFieldWidget(
                    onSubmitted: (value) {
                      _signUpOnSubmit(c);
                    },
                    obscureText: obscureText,
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                      child: Icon(
                        obscureText == true
                            ? FontAwesomeIcons.eyeSlash
                            : FontAwesomeIcons.eye,
                        color: Colors.black,
                      ),
                    ),
                    texttFieldController: comfirmPasswordController,
                    hintText: 'comfirm password'),
                SizedBox(
                  height: SizeConfig.screenHeight(c) * 0.03,
                ),
                InkWell(
                  onTap: isLoading == true
                      ? () {}
                      : () {
                          _signUpOnSubmit(c);
                        },
                  child: isLoading == true
                      ? const Center(child: CircularProgressIndicator())
                      : SizedBox(
                          width: (SizeConfig.screenWidth)(c),
                          child: OptionView(
                            blueColor,
                            'SignUp',
                            padding: 15,
                          )),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight(c) * 0.04,
                ),
                InkWell(
                  onTap: () {
                    GoRouter.of(c).go('/signin');
                  },
                  child: RichText(
                    text: const TextSpan(
                      text: 'Already have an account?',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: ' SignIn',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: blueColor02)),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight(c) * 0.07,
                ),
                InkWell(
                  onTap: () {
                    ref
                        .read(authenticationProvider)
                        .signInWithGoogle(c)
                        .then((value) {
                      debugPrint("email sign up complete. Return: $value");
                      GoRouter.of(c).go('/authwrapper');
                    });
                  },
                  child: Container(
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
                          height: SizeConfig.screenHeight(c) * 0.03,
                        ),
                        SizedBox(
                          width: SizeConfig.screenWidth(c) * 0.1,
                        ),
                        const Text('SignIn  With Google',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight(c) * 0.05,
                ),
              ])),
        ));
  }

  _signUpOnSubmit(BuildContext c) {
    if (emailController.text == '') {
      ScaffoldMessenger.of(c).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(right: 10, left: 10, bottom: 10),
          backgroundColor: blueColor,
          content: Text('Email is required'),
        ),
      );
    } else if (passwordController.text == '') {
      ScaffoldMessenger.of(c).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(right: 10, left: 10, bottom: 10),
          backgroundColor: blueColor,
          content: Text('Password is required'),
        ),
      );
    } else if (fullNameController.text == '') {
      ScaffoldMessenger.of(c).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(right: 10, left: 10, bottom: 10),
          backgroundColor: blueColor,
          content: Text('Full Name is required'),
        ),
      );
    } else if (comfirmPasswordController.text == '') {
      ScaffoldMessenger.of(c).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(right: 10, left: 10, bottom: 10),
          backgroundColor: blueColor,
          content: Text('Comfirm Password is required'),
        ),
      );
    } else if (passwordController.text != comfirmPasswordController.text) {
      ScaffoldMessenger.of(c).showSnackBar(
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(right: 10, left: 10, bottom: 10),
          backgroundColor: blueColor,
          content: Text('Password do not match'),
        ),
      );
    } else {
      setState(() {
        isLoading = true;
      });
      ref
          .read(authenticationProvider)
          .signUpWithEmailAndPassword(fullNameController.text,
              emailController.text, passwordController.text, c)
          .then((value) {
        debugPrint("email sign up complete. Return: $value");
        // GoRouter.of(c).go('/authwrapper');
      });
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}
