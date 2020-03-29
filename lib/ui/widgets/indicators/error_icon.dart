import 'package:flutter/material.dart';

import 'package:covid19_info/ui/widgets/indicators/icon_indicator.dart';

class ErrorIcon extends StatelessWidget {
  final String message;

  const ErrorIcon({
    this.message = 'An error has occured!',
  });

  @override
  Widget build(BuildContext context) {
    return IconIndicator(
      label: message,
      imageUrl: 'assets/images/error.png',
    );
  }
}
