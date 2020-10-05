import 'package:flutter/material.dart';

import 'package:covid19_info/ui/styles/styles.dart';

class InfoTabBar extends StatelessWidget {
  const InfoTabBar();

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        tabBar: TabBar(
          isScrollable: true,
          labelStyle: AppTextStyles.smallLight,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.light,
          indicatorColor: AppColors.primary,
          indicatorSize: TabBarIndicatorSize.label,
          tabs: const <Widget>[
            Tab(text: 'PODCASTS'),
            Tab(text: 'MYTHS'),
            Tab(text: 'FAQ'),
            Tab(text: 'HOSPITALS'),
          ],
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final PreferredSizeWidget tabBar;

  const _SliverAppBarDelegate({
    @required this.tabBar,
  }) : assert(tabBar != null);

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      elevation: 8.0,
      color: AppColors.background,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
