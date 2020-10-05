import 'package:flutter/material.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:covid19_info/ui/widgets/common/scale_animator.dart';

class StatCard extends StatelessWidget {
  final String label;
  final String count;
  final Color color;
  final Color backgroundColor;

  const StatCard({
    @required this.label,
    @required this.count,
    @required this.color,
    this.backgroundColor = AppColors.dark,
  })  : assert(label != null),
        assert(count != null),
        assert(color != null);

  @override
  Widget build(BuildContext context) {
    return ScaleAnimator(
      child: Container(
        width: 100.0,
        height: 100.0,
        margin: const EdgeInsets.all(6.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: AutoSizeText(
                label.isEmpty ? 'N/A' : label,
                textAlign: TextAlign.center,
                style: AppTextStyles.smallLight,
              ),
            ),
            const SizedBox(height: 12.0),
            Flexible(
              child: AutoSizeText(
                count,
                style: AppTextStyles.largeLight.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
