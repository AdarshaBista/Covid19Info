import 'package:flutter/material.dart';

import 'package:covid19_info/core/models/country.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:covid19_info/ui/styles/styles.dart';

class TopInfectedGraph extends StatelessWidget {
  final List<Country> mostInfected;

  const TopInfectedGraph({
    @required this.mostInfected,
  }) : assert(mostInfected != null);

  @override
  Widget build(BuildContext context) {
    final double maxY = mostInfected.first.data.cases.toDouble();
    final double hInterval = 100000.0;

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.center,
        groupsSpace: 12.0,
        maxY: maxY,
        gridData: FlGridData(
          show: true,
          drawHorizontalLine: true,
          horizontalInterval: hInterval,
        ),
        borderData: FlBorderData(show: false),
        axisTitleData: FlAxisTitleData(show: false),
        titlesData: FlTitlesData(
          bottomTitles: SideTitles(
            showTitles: true,
            margin: 12.0,
            reservedSize: 32.0,
            textStyle: AppTextStyles.extraSmallLight,
            getTitles: (value) => mostInfected[value.toInt()].data.name,
          ),
          leftTitles: SideTitles(
            showTitles: true,
            margin: 8.0,
            interval: hInterval,
            reservedSize: 32.0,
            textStyle: AppTextStyles.extraSmallLight,
            getTitles: (value) => value.toInt().toString(),
          ),
        ),
        barGroups: [
          for (int i = 0; i < mostInfected.length; ++i)
            _makeBarGroup(
              i,
              [
                _makeBarRod(
                  mostInfected[i].data.cases.toDouble(),
                  Colors.blue,
                ),
                _makeBarRod(
                  mostInfected[i].data.recovered.toDouble(),
                  Colors.green,
                ),
                _makeBarRod(
                  mostInfected[i].data.deaths.toDouble(),
                  Colors.red,
                ),
              ],
            )
        ],
      ),
    );
  }

  BarChartGroupData _makeBarGroup(int x, List<BarChartRodData> barRods) {
    return BarChartGroupData(
      x: x,
      barsSpace: 3.0,
      barRods: barRods,
    );
  }

  BarChartRodData _makeBarRod(double y, Color color) {
    return BarChartRodData(
      y: y,
      color: color,
      width: 6.0,
      borderRadius: BorderRadius.circular(4.0),
    );
  }
}
