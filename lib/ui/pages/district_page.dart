import 'package:flutter/material.dart';

import 'package:covid19_info/core/models/district.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:covid19_info/ui/widgets/district_page/district_map.dart';
import 'package:covid19_info/ui/widgets/district_page/district_panel.dart';

class DistrictPage extends StatelessWidget {
  final District district;

  const DistrictPage({
    @required this.district,
  }) : assert(district != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: <Widget>[
          DistrictMap(district: district),
          _buildBackButton(context),
          SlidingUpPanel(
            color: AppColors.background,
            parallaxOffset: 0.3,
            backdropEnabled: true,
            parallaxEnabled: true,
            margin: EdgeInsets.zero,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
            minHeight: 170.0,
            maxHeight: MediaQuery.of(context).size.height * 0.7,
            panelBuilder: (sc) => DistrictPanel(district: district, controller: sc),
          ),
        ],
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Positioned(
      right: 12.0,
      child: SafeArea(
        child: GestureDetector(
          onTap: Navigator.of(context).pop,
          child: const CircleAvatar(
            radius: 18.0,
            child: Icon(Icons.close, size: 20.0),
          ),
        ),
      ),
    );
  }
}
