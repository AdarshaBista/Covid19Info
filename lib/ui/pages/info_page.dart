import 'package:flutter/material.dart';

import 'package:covid19_info/ui/widgets/common/collapsible_appbar.dart';
import 'package:covid19_info/ui/widgets/info_page/info_tab_bar.dart';
import 'package:covid19_info/ui/widgets/info_page/faq/faq_list.dart';
import 'package:covid19_info/ui/widgets/info_page/myth/myth_list.dart';
import 'package:covid19_info/ui/widgets/info_page/news/news_list.dart';
import 'package:covid19_info/ui/widgets/info_page/podcast/podcast_list.dart';
import 'package:covid19_info/ui/widgets/info_page/hospital/hospital_list.dart';

class InfoPage extends StatelessWidget {
  const InfoPage();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) => [
            const CollapsibleAppBar(
              elevation: 0.0,
              title: 'INFO',
              imageUrl: 'assets/images/info_header.png',
            ),
            const InfoTabBar(),
          ],
          body: const TabBarView(
            children: <Widget>[
              NewsList(),
              PodcastList(),
              MythList(),
              FaqList(),
              HospitalList(),
            ],
          ),
        ),
      ),
    );
  }
}
