import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:covid19_info/ui/styles/styles.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:covid19_info/ui/widgets/global_page/map_card.dart';
import 'package:covid19_info/ui/widgets/global_page/country_list.dart';
import 'package:covid19_info/ui/widgets/global_page/global_stats_tile.dart';

class GlobalPage extends StatefulWidget {
  @override
  _GlobalPageState createState() => _GlobalPageState();
}

class _GlobalPageState extends State<GlobalPage> {
  double panelPos = 0.0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: Stack(
          children: <Widget>[
            MapCard(),
            SlidingUpPanel(
              color: AppColors.background,
              parallaxOffset: 0.3,
              isDraggable: true,
              backdropEnabled: true,
              parallaxEnabled: true,
              backdropTapClosesPanel: true,
              slideDirection: SlideDirection.UP,
              margin: EdgeInsets.zero,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              maxHeight: MediaQuery.of(context).size.height * 0.8,
              minHeight: 96.0,
              onPanelSlide: (value) => setState(() {
                panelPos = value;
              }),
              panelBuilder: (sc) => _buildPanel(sc),
            ),
            Transform.scale(
              scale: 1.0 - panelPos,
              child: GlobalStatsTile(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPanel(ScrollController sc) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 8.0),
        Transform.rotate(
          angle: panelPos * math.pi,
          child: Icon(
            Icons.keyboard_arrow_up,
            color: Colors.white54,
            size: 16.0,
          ),
        ),
        Expanded(
          child: CountryList(controller: sc),
        ),
      ],
    );
  }
}
