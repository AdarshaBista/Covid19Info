import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:covid19_info/ui/styles/styles.dart';

class CountryStatChart extends StatelessWidget {
  final int active;
  final int recovered;
  final int deaths;
  final double radius;
  final double centerSpaceRadius;
  final bool showPercent;

  const CountryStatChart({
    @required this.active,
    @required this.recovered,
    @required this.deaths,
    this.radius = 8.0,
    this.centerSpaceRadius = 30.0,
    this.showPercent = false,
  })  : assert(active != null),
        assert(recovered != null),
        assert(deaths != null);

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sectionsSpace: 3.0,
        centerSpaceRadius: centerSpaceRadius,
        startDegreeOffset: -90.0,
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
    double total = (active + recovered + deaths).toDouble();
    double percent = value / total * 100.0;
    return PieChartSectionData(
      color: color,
      value: value,
      radius: radius,
      showTitle: showPercent,
      title: '${percent.toStringAsFixed(1)} %',
      titlePositionPercentageOffset: 1.3,
      titleStyle: AppTextStyles.smallLight,
    );
  }
}