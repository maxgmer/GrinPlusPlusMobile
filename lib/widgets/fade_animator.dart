import 'package:flutter/widgets.dart';
import 'package:simple_animations/simple_animations.dart';


class FadeAnimator extends StatelessWidget {
  final int duration;
  final int delay;
  final Widget child;
  final double startOpacity;
  final double endOpacity;
  final Curve curve;
  final AnimationStatusListener animationStatusListener;

  FadeAnimator({
    @required this.duration,
    @required this.delay,
    @required this.child,
    this.startOpacity = 0,
    this.endOpacity = 1,
    this.curve = Curves.linear,
    this.animationStatusListener,
  });

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("opacity").add(
        Duration(milliseconds: duration),
        Tween(begin: startOpacity, end: endOpacity),
      ),
    ]);

    return ControlledAnimation(
      delay: Duration(milliseconds: delay),
      duration: tween.duration,
      tween: tween,
      child: child,
      animationControllerStatusListener: animationStatusListener,
      builderWithChild: (context, child, animation) => Opacity(
        opacity: animation["opacity"],
        child: child,
      ),
    );
  }
}