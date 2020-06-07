import 'package:flutter/material.dart';

import 'package:animator/animator.dart';

class FadeAnimator extends StatelessWidget {
  final Widget child;

  const FadeAnimator({
    @required this.child,
  }) : assert(child != null);

  @override
  Widget build(BuildContext context) {
    return Animator(
      child: child,
      curve: Curves.easeIn,
      duration: const Duration(milliseconds: 200),
      builder: (context, animatorState, widget) => FadeTransition(
        opacity: animatorState.animation,
        child: widget,
      ),
    );
  }
}
