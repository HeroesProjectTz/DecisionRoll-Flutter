// ignore_for_file: file_names

import 'package:flutter/widgets.dart';

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? blockSizeHorizontal;
  static double? blockSizeVertical;

  SizeConfig(BuildContext c) {
    _mediaQueryData = MediaQuery.of(c);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    blockSizeHorizontal = (screenWidth! / 100);
    blockSizeVertical = (screenHeight! / 100);
  }

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    blockSizeHorizontal = screenWidth! / 100;
    blockSizeVertical = screenHeight! / 100;
  }

  double top() {
    if (screenHeight! > 600) {
      return screenHeight! * 0.3;
    } else {
      return screenHeight! * 0.2;
    }
  }

  double signTop() {
    if (screenHeight! > 700) {
      return screenHeight! * 0.3;
    } else {
      return screenHeight! * 0.1;
    }
  }
}
