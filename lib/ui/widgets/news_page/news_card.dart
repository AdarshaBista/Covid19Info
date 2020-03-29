import 'package:flutter/material.dart';

import 'package:covid19_info/core/models/news.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:covid19_info/ui/widgets/common/tag.dart';

class NewsCard extends StatelessWidget {
  final News news;
  final Color color;

  const NewsCard({
    @required this.news,
    this.color = AppColors.primary,
  }) : assert(news != null);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 11 / 16,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.dark,
          borderRadius: BorderRadius.circular(16.0),
          image: DecorationImage(
            image: NetworkImage(news.imageUrl),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              AppColors.background.withOpacity(0.85),
              BlendMode.srcATop,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildTitle(),
            Divider(height: 16.0, color: color.withOpacity(0.4)),
            _buildSummary(),
            Divider(height: 16.0, color: color.withOpacity(0.4)),
            _buildDate(),
            const SizedBox(height: 16.0),
            _buildSource(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Flexible(
      child: Text(
        news.title,
        textAlign: TextAlign.center,
        style: AppTextStyles.extraLargeLightSerif,
      ),
    );
  }

  Widget _buildSummary() {
    return Flexible(
      child: SingleChildScrollView(
        child: Text(
          news.summary,
          textAlign: TextAlign.justify,
          style: AppTextStyles.mediumLight,
        ),
      ),
    );
  }

  Widget _buildDate() {
    final DateTime c = news.createdAt;
    return Text(
      '${c.year}/${c.month}/${c.day}',
      textAlign: TextAlign.left,
      style: AppTextStyles.extraSmallLight,
    );
  }

  Widget _buildSource() {
    return Tag(
      label: news.source,
      color: color,
      onPressed: () {
        // TODO: Open link in webview
      },
    );
  }
}
