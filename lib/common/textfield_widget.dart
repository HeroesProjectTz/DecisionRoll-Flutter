import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextFieldWidget extends StatelessWidget {
  TextFieldWidget({
    Key? key,
    required this.texttFieldController,
    required this.hintText,
    this.obscureText = false,
    this.enabled = true,
    this.onSubmitted,
    this.textInputType = TextInputType.name,
    this.prefixIcon,
    this.suffixIcon,
  }) : super(key: key);

  final TextEditingController texttFieldController;
  final String hintText;
  Widget? prefixIcon;
  Widget? suffixIcon;
  bool? obscureText;
  Function(String)? onSubmitted;
  bool? enabled;
  TextInputType? textInputType;
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: textInputType,
      controller: texttFieldController,
      obscureText: obscureText!,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,

        fillColor: const Color(0xffD9D9D9),
        filled: true,
        isDense: true,
        enabled: enabled!,
        // focusColor: Colors.transparent,
        contentPadding: const EdgeInsets.all(15),
        border: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xffD9D9D9), width: 0.0),
            borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
