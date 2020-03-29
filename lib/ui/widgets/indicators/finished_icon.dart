import 'package:flutter/material.dart';

import 'package:covid19_info/ui/widgets/indicators/icon_indicator.dart';

class FinishedIcon extends StatelessWidget {
  const FinishedIcon();

  @override
  Widget build(BuildContext context) {
    return IconIndicator(
      label: "That's it for now.",
      imageUrl: 'assets/images/finished.png',
    );
  }
}
