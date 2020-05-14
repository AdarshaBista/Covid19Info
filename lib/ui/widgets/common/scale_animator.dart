import 'package:flutter/material.dart';

import 'package:animator/animator.dart';

class ScaleAnimator extends StatelessWidget {
  final Widget child;
  final int duration;

  const ScaleAnimator({
    @required this.child,
    this.duration = 500,
  }) : assert(child != null);

  @override
  Widget build(BuildContext context) {
    return Animator(
      curve: Curves.linearToEaseOut,
      duration: Duration(milliseconds: duration),
      builder: (Animation anim) => Transform.scale(
        scale: anim.value,
        child: child,
      ),
    );
  }
}
