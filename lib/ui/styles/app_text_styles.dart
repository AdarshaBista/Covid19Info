import 'package:flutter/material.dart';

import 'package:covid19_info/ui/styles/app_colors.dart';

class AppTextStyles {
  static const TextStyle _base = TextStyle(
    color: AppColors.background,
    fontFamily: 'Sen',
  );

  // Dark
  static final TextStyle extraLargeDark = _base.copyWith(
    fontSize: 28.0,
    fontWeight: FontWeight.w700,
    letterSpacing: 1,
  );

  static final TextStyle largeDark = _base.copyWith(
    fontSize: 20.0,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle mediumDark = _base.copyWith(
    fontSize: 18.0,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle smallDark = _base.copyWith(
    color: Colors.black87,
    fontSize: 15.0,
    fontWeight: FontWeight.w200,
  );

  static final TextStyle extraSmallDark = _base.copyWith(
    color: Colors.black54,
    fontSize: 12.0,
    fontWeight: FontWeight.w200,
  );

  // Light
  static final TextStyle extraLargeLight = extraLargeDark.copyWith(
    color: AppColors.accent,
  );

  static final TextStyle largeLight = largeDark.copyWith(
    color: AppColors.accent,
  );

  static final TextStyle mediumLight = mediumDark.copyWith(
    color: AppColors.accent,
  );

  static final TextStyle smallLight = smallDark.copyWith(
    color: AppColors.accent.withOpacity(0.8),
  );

  static final TextStyle extraSmallLight = extraSmallDark.copyWith(
    color: AppColors.accent.withOpacity(0.6),
  );
}
