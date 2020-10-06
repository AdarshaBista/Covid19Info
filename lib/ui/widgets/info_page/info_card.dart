import 'package:flutter/material.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:covid19_info/ui/widgets/common/tag.dart';
import 'package:covid19_info/ui/widgets/common/fade_animator.dart';

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
    return FadeAnimator(
      child: ExpansionTile(
        backgroundColor: color.withOpacity(0.2),
        title: _buildTitle(),
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildSubTitle(),
              _buildTag(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title.trim(),
        textAlign: TextAlign.left,
        style: AppTextStyles.mediumLightSerif,
      ),
    );
  }

  Widget _buildSubTitle() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        subTitle.trim(),
        style: AppTextStyles.smallLightSerif,
      ),
    );
  }

  Widget _buildTag() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
      child: Tag(
        label: tag,
        color: color,
        iconData: null,
      ),
    );
  }
}
