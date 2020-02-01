import 'package:flutter/material.dart';
import 'package:grin_plus_plus/colors.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      color: kColorBackgroundGrey,
      child: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.transparent,
          strokeWidth: 3.0,
        ),
      ),
    );
  }
}