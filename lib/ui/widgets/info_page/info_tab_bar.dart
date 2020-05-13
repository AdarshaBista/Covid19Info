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
          labelColor: AppColors.secondary,
          unselectedLabelColor: AppColors.light,
          indicatorWeight: 2.0,
          indicatorColor: AppColors.secondary,
          indicatorSize: TabBarIndicatorSize.label,
          tabs: <Widget>[
            const Tab(
              text: 'PODCASTS',
            ),
            const Tab(
              text: 'MYTHS',
            ),
            const Tab(
              text: 'FAQ',
            ),
            const Tab(
              text: 'HOSPITALS',
            ),
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
