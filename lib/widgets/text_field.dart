import 'package:flutter/material.dart';
import 'package:grin_plus_plus/colors.dart';

class BorderedTextField extends StatelessWidget {
  final TextEditingController controller;
  final Color boxColor;
  final Color labelColor;
  final bool obscureText;
  final String labelText;
  final bool enabled;

  BorderedTextField({
    this.controller,
    this.boxColor = kColorAlmostWhite,
    this.labelColor = kColorAlmostWhite,
    this.obscureText = false,
    this.labelText,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      enabled: enabled,
      cursorColor: kColorAlmostWhite,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w300,
        color: kColorAlmostWhite,
      ),
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: boxColor,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: boxColor,
            width: 1.5,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: boxColor.withOpacity(0.2),
            width: 1.5,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15.0,
          horizontal: 10,
        ),
        labelText: labelText,
        labelStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w300,
          color: labelColor,
        ),
      ),
      controller: controller,
      textInputAction: TextInputAction.done,
      obscureText: obscureText,
    );
  }
}