import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeView extends StatelessWidget {
  String decisionId;
  QrCodeView({
    Key? key,
    required this.decisionId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: QrImage(
        data: "https://decisionrollmobile.vercel.app/#/decision/$decisionId",
        version: QrVersions.auto,
        // size: 200.0,
        // backgroundColor: Colors.black,
        foregroundColor: Colors.black,
      ),
    ));
  }
}
