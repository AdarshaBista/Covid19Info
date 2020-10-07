import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:covid19_info/core/models/district.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:covid19_info/ui/styles/styles.dart';

class GenderBarGraph extends StatelessWidget {
  final District district;

  const GenderBarGraph({
    @required this.district,
  }) : assert(district != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'GENDER DISTRIBUTION',
          style: AppTextStyles.smallLight,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 24.0),
        _buildChart(),
      ],
    );
  }

  Widget _buildChart() {
    final maxY = math.max(district.maleCount, district.femaleCount).toDouble();

    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 32.0),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.center,
          minY: 0.0,
          maxY: maxY,
          groupsSpace: 32.0,
          titlesData: FlTitlesData(
            leftTitles: SideTitles(
              showTitles: true,
              interval: maxY / 6.0,
              textStyle: AppTextStyles.extraSmallLight,
              reservedSize: 50.0,
            ),
            bottomTitles: SideTitles(
              showTitles: true,
              textStyle: AppTextStyles.extraSmallLight,
              getTitles: (value) {
                final index = value.toInt();
                if (index == 0) return 'Male';
                if (index == 1) return 'Female';
                return 'N/A';
              },
            ),
          ),
          borderData: FlBorderData(
            border: const Border(bottom: BorderSide(color: Colors.white60)),
          ),
          gridData: FlGridData(
            drawHorizontalLine: true,
            horizontalInterval: maxY / 6.0,
          ),
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              tooltipBgColor: AppColors.primary,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(rod.y.toStringAsFixed(0), AppTextStyles.smallLight);
              },
            ),
          ),
          barGroups: [
            _buildBarGroup(0, district.maleCount, Colors.blue),
            _buildBarGroup(1, district.femaleCount, Colors.pink),
            _buildBarGroup(2, district.naCount, Colors.teal),
          ],
        ),
      ),
    );
  }

  BarChartGroupData _buildBarGroup(int index, int count, Color color) {
    return BarChartGroupData(
      x: index,
      barRods: [
        BarChartRodData(
          width: 32.0,
          y: count.toDouble(),
          color: color.withOpacity(0.7),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4.0),
            topRight: Radius.circular(4.0),
          ),
        ),
      ],
    );
  }
}
