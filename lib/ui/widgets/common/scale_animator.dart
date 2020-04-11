import 'package:flutter/material.dart';

import 'package:animator/animator.dart';

class ScaleAnimator extends StatelessWidget {
  final Widget child;

  const ScaleAnimator({
    @required this.child,
  }) : assert(child != null);

  @override
  Widget build(BuildContext context) {
    return Animator(
      curve: Curves.linearToEaseOut,
      duration: const Duration(milliseconds: 400),
      builder: (Animation anim) => Transform.scale(
        scale: anim.value,
        child: child,
      ),
    );
  }
}
