import 'dart:math';

import 'package:flutter/material.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:covid19_info/core/models/myth.dart';

import 'package:covid19_info/ui/widgets/common/tag.dart';

class MythCard extends StatelessWidget {
  final Myth myth;

  const MythCard({
    @required this.myth,
  }) : assert(myth != null);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 9 / 16,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.dark,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildMyth(),
            const Spacer(),
            const SizedBox(height: 20.0),
            _buildReality(),
            const SizedBox(height: 20.0),
            Tag(
              label: myth.sourceName,
              color: AppColors.accentColors[
                  Random().nextInt(AppColors.accentColors.length)],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMyth() {
    return Flexible(
      child: SingleChildScrollView(
        child: Text(
          myth.myth,
          textAlign: TextAlign.left,
          style: AppTextStyles.extraLargeLight.copyWith(
            fontFamily: 'Sura',
          ),
        ),
      ),
    );
  }

  Widget _buildReality() {
    return Flexible(
      child: SingleChildScrollView(
        child: Text(
          myth.reality,
          textAlign: TextAlign.left,
          style: AppTextStyles.largeLight,
        ),
      ),
    );
  }
}
