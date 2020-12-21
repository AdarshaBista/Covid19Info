import 'package:flutter/material.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:covid19_info/ui/widgets/common/fade_animator.dart';

class SearchBox extends StatelessWidget {
  final Function(String) onChanged;
  final String hintText;
  final EdgeInsets margin;
  final BorderRadiusGeometry borderRadius;

  const SearchBox({
    this.onChanged,
    this.hintText = 'Search',
    this.margin = const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return FadeAnimator(
      child: Container(
        height: 50.0,
        margin: margin,
        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 10.0),
        decoration: BoxDecoration(
          color: AppColors.dark,
          borderRadius: borderRadius ?? BorderRadius.circular(8.0),
        ),
        child: TextFormField(
          onChanged: onChanged,
          style: AppTextStyles.smallLight,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            prefixIcon: const Icon(
              Icons.search,
              size: 20.0,
              color: AppColors.light,
            ),
          ),
        ),
      ),
    );
  }
}
