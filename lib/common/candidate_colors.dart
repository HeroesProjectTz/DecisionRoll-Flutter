import 'package:decisionroll/utilities/colors.dart';
import 'package:flutter/rendering.dart';

class CandidateColors {
  static final _colors = [
    const Color.fromRGBO(128, 0, 128, 1),
    const Color.fromRGBO(117, 72, 179, 1),
    const Color.fromRGBO(90, 115, 218, 1),
    const Color.fromRGBO(50, 154, 253, 1),
    const Color.fromRGBO(0, 190, 255, 1),
    const Color.fromRGBO(66, 143, 221, 1),
    const Color.fromRGBO(211, 151, 254, 1)
  ];
  static final _overflowColor = Color(0xff494949);
  static const overflowIndex = 7;
  static Color getColorFromIdx(int idx) {
    if (idx < _colors.length) {
      return _colors[idx];
    } else {
      return _overflowColor;
    }
  }
}
