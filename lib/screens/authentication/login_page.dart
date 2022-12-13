import 'package:decisionroll/common/common_methods.dart';
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

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
                  "Welcome Back!",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight(c) * 0.08,
                ),
                TextFieldWidget(
                    isEmail: true,
                    texttFieldController: emailController,
                    hintText: 'Enter your email'),
                SizedBox(
                  height: SizeConfig.screenHeight(c) * 0.05,
                ),
                TextFieldWidget(
                    onSubmitted: (value) {
                      _loginOnSubmit(c);
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
                    texttFieldController: passwordController,
                    hintText: 'password'),
                SizedBox(
                  height: SizeConfig.screenHeight(c) * 0.03,
                ),
                InkWell(
                  onTap: isLoading == true
                      ? () {}
                      : () {
                          _loginOnSubmit(c);
                        },
                  child: isLoading == true
                      ? const Center(child: CircularProgressIndicator())
                      : SizedBox(
                          width: SizeConfig.screenWidth(c),
                          child: OptionView(
                            blueColor,
                            'SignIn',
                            padding: 15,
                          )),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight(c) * 0.04,
                ),
                InkWell(
                  onTap: () {
                    GoRouter.of(c).go('/signup');
                  },
                  child: RichText(
                    text: const TextSpan(
                      text: 'Does\'nt have an account?',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: ' SignUp',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: blueColor02)),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight(c) * 0.15,
                ),
                InkWell(
                  onTap: () {
                    ref.read(authenticationProvider).signInWithGoogle(c);
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

  _loginOnSubmit(BuildContext c) {
    if (emailController.text == '') {
      ref.read(commonMethodsProvider).showSnackBarMessage(c, 'Email required');
    } else if (passwordController.text == '') {
      ref
          .read(commonMethodsProvider)
          .showSnackBarMessage(c, 'Passowrd required');
    } else {
      setState(() {
        isLoading = true;
      });
      ref
          .read(authenticationProvider)
          .signInWithEmailAndPassword(
              emailController.text, passwordController.text, c)
          .then((value) {
        debugPrint("email sign in complete. Return: $value");
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
