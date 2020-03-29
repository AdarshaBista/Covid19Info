import 'package:flutter/material.dart';

import 'package:covid19_info/ui/styles/styles.dart';

import 'package:covid19_info/ui/widgets/common/tag.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final String tag;
  final Color color;

  const InfoCard({
    @required this.title,
    @required this.subTitle,
    @required this.tag,
    this.color = AppColors.primary,
  })  : assert(title != null),
        assert(subTitle != null),
        assert(tag != null);

  @override
  Widget build(BuildContext context) {
    return Container(
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
          _buildTitle(),
          const SizedBox(height: 16.0),
          _buildSubTitle(),
          const SizedBox(height: 16.0),
          Tag(label: tag, color: color),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Flexible(
      child: Text(
        title,
        textAlign: TextAlign.left,
        style: AppTextStyles.extraLargeLightSerif,
      ),
    );
  }

  Widget _buildSubTitle() {
    return Flexible(
      child: Text(
        subTitle,
        textAlign: TextAlign.left,
        style: AppTextStyles.mediumLight,
      ),
    );
  }
}
