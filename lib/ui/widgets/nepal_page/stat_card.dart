import 'package:flutter/material.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:auto_size_text/auto_size_text.dart';

class StatCard extends StatelessWidget {
  final String label;
  final String count;
  final Color color;

  const StatCard({
    @required this.label,
    @required this.count,
    @required this.color,
  })  : assert(label != null),
        assert(count != null),
        assert(color != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      height: 100.0,
      margin: const EdgeInsets.all(6.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: AppColors.dark,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: AutoSizeText(
              label,
              style: AppTextStyles.smallLight,
            ),
          ),
          const SizedBox(height: 12.0),
          Flexible(
            child: AutoSizeText(
              count,
              style: AppTextStyles.extraLargeLight.copyWith(color: color),
            ),
          ),
        ],
      ),
    );
  }
}
