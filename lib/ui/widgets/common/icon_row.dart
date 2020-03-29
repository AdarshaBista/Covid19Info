import 'package:flutter/material.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:auto_size_text/auto_size_text.dart';

class IconRow extends StatelessWidget {
  final String label;
  final IconData iconData;
  final TextStyle labelStyle;
  final Color color;

  const IconRow({
    @required this.label,
    @required this.iconData,
    this.labelStyle,
    this.color = AppColors.light,
  })  : assert(label != null),
        assert(iconData != null);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          iconData,
          color: color,
          size: 20.0,
        ),
        const SizedBox(width: 16.0),
        Flexible(
          child: AutoSizeText(
            label,
            maxLines: 2,
            style:
                labelStyle ?? AppTextStyles.mediumLight.copyWith(color: color),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
