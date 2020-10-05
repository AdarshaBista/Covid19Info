import 'package:flutter/material.dart';

import 'package:covid19_info/ui/widgets/indicators/icon_indicator.dart';

class EmptyIcon extends StatelessWidget {
  const EmptyIcon();

  @override
  Widget build(BuildContext context) {
    return const IconIndicator(
      label: 'Nothing here...',
      imageUrl: 'assets/images/empty.png',
    );
  }
}
