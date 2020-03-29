import 'package:flutter/material.dart';

import 'package:covid19_info/ui/styles/styles.dart';

class Tag extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const Tag({
    @required this.label,
    this.color = AppColors.primary,
    this.onPressed,
  }) : assert(label != null);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: color.withOpacity(0.8),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(width: 8.0),
            Text(
              label,
              style: AppTextStyles.extraSmallLight,
            ),
            const SizedBox(width: 8.0),
            if (onPressed != null)
              Icon(
                Icons.arrow_forward,
                size: 12.0,
              ),
          ],
        ),
      ),
    );
  }
}
