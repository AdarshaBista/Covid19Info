import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';

class CountryStatChart extends StatelessWidget {
  final int active;
  final int recovered;
  final int deaths;

  const CountryStatChart({
    @required this.active,
    @required this.recovered,
    @required this.deaths,
  })  : assert(active != null),
        assert(recovered != null),
        assert(deaths != null);

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sectionsSpace: 4.0,
        centerSpaceRadius: 24.0,
        borderData: FlBorderData(show: false),
        sections: [
          _makeSection(active.toDouble(), Colors.yellow),
          _makeSection(recovered.toDouble(), Colors.green),
          _makeSection(deaths.toDouble(), Colors.red),
        ],
      ),
    );
  }

  PieChartSectionData _makeSection(double value, Color color) {
    return PieChartSectionData(
      color: color,
      value: value,
      radius: 12.0,
      showTitle: false,
    );
  }
}
