import 'package:flutter/material.dart';

import 'package:covid19_info/ui/widgets/common/collapsible_appbar.dart';
import 'package:covid19_info/ui/widgets/global_page/country_list.dart';
import 'package:covid19_info/ui/widgets/global_page/global_stats_row.dart';
import 'package:covid19_info/ui/widgets/global_page/top_infected_stats.dart';

class GlobalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => [
          const CollapsibleAppBar(
            elevation: 0.0,
            title: 'GLOBAL STATS',
            imageUrl: 'assets/images/global_header.png',
          ),
        ],
        body: ListView(
          shrinkWrap: true,
          children: <Widget>[
            const SizedBox(height: 16.0),
            GlobalStatsRow(),
            const SizedBox(height: 16.0),
            TopInfectedStats(),
            const SizedBox(height: 16.0),
            CountryList(),
          ],
        ),
      ),
    );
  }
}
