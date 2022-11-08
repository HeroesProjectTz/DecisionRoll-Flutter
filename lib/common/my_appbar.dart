import 'package:decisionroll/utilities/colors.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// you can add more fields that meet your needs
  final double height;
  final String title;
  final Color color;
  final Color titlecolor;
  const MyAppBar(
      {this.title = '',
      this.color = whiteBackgroundColor,
      this.titlecolor = Colors.black,
      this.height = kToolbarHeight,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // SizeConfig(context);
    return AppBar(
      // height: preferredSize.height,/
      iconTheme: const IconThemeData(color: blueColor),
      backgroundColor: color,
      title: Text(title,
          style: TextStyle(
            color: titlecolor,
          )),
      centerTitle: true,
      elevation: 0.0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
