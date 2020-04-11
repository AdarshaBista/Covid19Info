import 'package:flutter/material.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:covid19_info/ui/widgets/global_page/global_stats_details.dart';

class GlobalStatsTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: EdgeInsets.all(12.0),
      clipBehavior: Clip.antiAlias,
      color: AppColors.dark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: ExpansionTile(
        backgroundColor: AppColors.dark,
        leading: Icon(LineAwesomeIcons.globe),
        title: Text(
          'GLOBAL STATS',
          style: AppTextStyles.mediumLight,
        ),
        children: [
          GlobalStatsDetails(),
        ],
      ),
    );
  }
}
