import 'package:flutter/widgets.dart';
import 'package:simple_animations/simple_animations.dart';

class FadeIn extends StatelessWidget {
  final int duration;
  final int delay;
  final Widget child;

  FadeIn({
    @required this.duration,
    @required this.delay,
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("opacity").add(
        Duration(milliseconds: duration),
        Tween(begin: 0.0, end: 1.0),
      ),
    ]);

    return ControlledAnimation(
      delay: Duration(milliseconds: delay),
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context, child, animation) => Opacity(
        opacity: animation["opacity"],
        child: child,
      ),
    );
  }
}