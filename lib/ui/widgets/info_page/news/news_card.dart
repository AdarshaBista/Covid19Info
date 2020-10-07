import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:covid19_info/core/models/news.dart';
import 'package:covid19_info/core/services/launcher_service.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

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
      child: Stack(
        children: [
          _buildImage(),
          _buildContent(context),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: AppColors.dark,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Image.network(
            news.imageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            colorBlendMode: BlendMode.srcATop,
            color: AppColors.background.withOpacity(0.6),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildTitle(),
          Divider(height: 16.0, color: color.withOpacity(0.4)),
          _buildSummary(),
          Divider(height: 16.0, color: color.withOpacity(0.4)),
          _buildSource(),
          const SizedBox(height: 16.0),
          _buildReadMore(context),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Flexible(
      child: Text(
        news.title,
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
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

  Widget _buildSource() {
    final DateTime c = news.createdAt;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          news.source,
          style: AppTextStyles.extraSmallLight,
        ),
        Text(
          '${c.year}/${c.month}/${c.day}',
          textAlign: TextAlign.left,
          style: AppTextStyles.extraSmallLight,
        ),
      ],
    );
  }

  Widget _buildReadMore(BuildContext context) {
    return Tag(
      label: 'READ MORE',
      color: color,
      onPressed: () async {
        await context.repository<LauncherService>().launchWebsite(context, news.url);
      },
    );
  }
}
