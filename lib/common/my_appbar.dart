import 'package:decisionroll/common/sizeConfig.dart';
import 'package:decisionroll/utilities/colors.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// you can add more fields that meet your needs

  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: blueColor),
      backgroundColor: whiteBackgroundColor,
      elevation: 0.0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(SizeConfig.screenHeight! * 0.07);
}
