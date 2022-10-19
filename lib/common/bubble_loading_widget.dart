import 'package:flutter/material.dart';
import 'package:decisionroll/utilities/images.dart';
import 'package:lottie/lottie.dart';

class BubbleLoadingWidget extends StatelessWidget {
  const BubbleLoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Lottie.asset(bubbleloadingIcon, alignment: Alignment.center));
  }
}
