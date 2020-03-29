import 'package:flutter/material.dart';

import 'package:flutter_icons/flutter_icons.dart';
import 'package:covid19_info/ui/styles/styles.dart';

class InfoTabBar extends StatelessWidget {
  const InfoTabBar();

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: const _SliverAppBarDelegate(
        tabBar: const TabBar(
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: AppColors.primary,
          indicatorWeight: 1.0,
          isScrollable: true,
          tabs: <Widget>[
            const Tab(
              icon: Icon(
                Feather.x_circle,
                color: Colors.red,
              ),
            ),
            const Tab(
              icon: Icon(
                Icons.question_answer,
                color: Colors.blue,
              ),
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
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
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
