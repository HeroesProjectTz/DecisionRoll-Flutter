import 'package:decisionroll/utilities/colors.dart';
import 'package:flutter/rendering.dart';

class CandidateColors {
  static final _colors = [
    Color(0xffffaf00),
    Color(0xff00ff72),
    Color(0xfff700ff),
  ];
  static final _overflowColor = Color(0xff494949);

  static Color getColorFromIdx(int idx) {
    if (idx < _colors.length) {
      return _colors[idx];
    } else {
      return _overflowColor;
    }
  }
}
