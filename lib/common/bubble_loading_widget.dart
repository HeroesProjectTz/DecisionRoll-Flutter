import 'package:flutter/material.dart';

class BubbleLoadingWidget extends StatelessWidget {
  const BubbleLoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
        // child: Lottie.asset(bubbleloadingIcon, alignment: Alignment.center));
        child: CircularProgressIndicator());
  }
}
