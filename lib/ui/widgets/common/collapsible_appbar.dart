import 'package:flutter/material.dart';

import 'package:covid19_info/ui/styles/styles.dart';

class CollapsibleAppBar extends StatelessWidget {
  final String title;
  final String imageUrl;
  final double elevation;

  const CollapsibleAppBar({
    @required this.title,
    @required this.imageUrl,
    this.elevation = 8.0,
  })  : assert(title != null),
        assert(imageUrl != null);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppColors.background,
      pinned: true,
      centerTitle: true,
      elevation: elevation,
      expandedHeight: 140.0,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.all(16.0),
        centerTitle: true,
        title: Text(
          title,
          style: AppTextStyles.extraLargeLight,
        ),
        background: Padding(
          padding: const EdgeInsets.only(left: 60.0, right: 60.0, top: 20.0),
          child: Image.asset(
            imageUrl,
            color: AppColors.dark,
            alignment: Alignment.centerRight,
          ),
        ),
      ),
    );
  }
}
