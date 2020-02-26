import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grin_plus_plus/colors.dart';
import 'package:grin_plus_plus/strings.dart';
import 'package:grin_plus_plus/widgets/fade_animator.dart';
import 'package:grin_plus_plus/widgets/fade_in.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FadeIn(
            child: Text(
              '$kHelloString!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  color: kColorAlmostWhite,
                  fontWeight: FontWeight.w300,
                )
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 20),
            width: MediaQuery.of(context).size.width * 0.5,
            child: FadeAnimator(
              startOpacity: 0,
              endOpacity: 1,
              duration: 1500,
              delay: 3000,
              child: Text(
                '$kIntroString.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: kColorAlmostWhite,
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}