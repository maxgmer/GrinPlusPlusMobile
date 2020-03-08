import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grin_plus_plus/colors.dart';

class BorderedTextFieldWithInnerText extends StatelessWidget {
  final bool enabled;
  final bool obscureText;
  final String text;
  final TextEditingController controller;
  final EdgeInsets margin;

  BorderedTextFieldWithInnerText({
    this.enabled = true,
    this.obscureText = false,
    this.text = '',
    this.controller,
    this.margin = const EdgeInsets.all(8.0),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: enabled ? kColorAlmostWhite : kColorAlmostWhite.withOpacity(0.2),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(4)
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: kColorAlmostWhite,
                ),
              ),
            ),
            Expanded(
              child: TextField(
                enabled: enabled,
                obscureText: obscureText,
                cursorColor: kColorAlmostWhite,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: kColorAlmostWhite,
                ),
                controller: controller,
              ),
            ),
          ],
        ),
      ),
    );
  }
}