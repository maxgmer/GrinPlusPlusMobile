import 'package:flutter/cupertino.dart';
import 'package:grin_plus_plus/widgets/fade_animator.dart';

class FadeIn extends StatelessWidget {
  final Widget child;

  FadeIn({@required this.child});

  @override
  Widget build(BuildContext context) {
    return FadeAnimator(
      startOpacity: 0,
      endOpacity: 1,
      duration: 1500,
      delay: 1000,
      child: child,
    );
  }
}