import 'package:decisionroll/common/sizeConfig.dart';
import 'package:decisionroll/utilities/colors.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// you can add more fields that meet your needs
  final double height;
  MyAppBar({this.height = kToolbarHeight, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // SizeConfig(context);
    return AppBar(
      // height: preferredSize.height,/
      iconTheme: const IconThemeData(color: blueColor),
      backgroundColor: whiteBackgroundColor,
      elevation: 0.0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
