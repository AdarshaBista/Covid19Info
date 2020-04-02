import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:covid19_info/core/models/timeline_data.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:covid19_info/ui/styles/styles.dart';

class TimelineGraph extends StatelessWidget {
  final List<TimelineData> timelineData;

  const TimelineGraph({
    @required this.timelineData,
  }) : assert(timelineData != null);

  @override
  Widget build(BuildContext context) {
    final double labelSize = 40.0;
    final double maxX = timelineData.length.toDouble();
    final double maxY =
        timelineData.map((e) => e.confirmed).reduce(math.max).toDouble();

    final double verticalInterval = (maxX ~/ 5).toDouble();
    final double horizontalInterval = (maxY ~/ 5).toDouble();
    final List<double> xValues = timelineData
        .map((data) => timelineData.indexOf(data).toDouble())
        .toList();

    return Container(
      padding: const EdgeInsets.only(top: 16.0, right: 16.0, bottom: 16.0),
      child: LineChart(
        LineChartData(
          lineTouchData: LineTouchData(
            handleBuiltInTouches: true,
            touchTooltipData: LineTouchTooltipData(
              tooltipBgColor: AppColors.background.withOpacity(0.7),
            ),
          ),
          minX: 0.0,
          minY: 0.0,
          maxY: maxY,
          gridData: FlGridData(
            show: true,
            horizontalInterval: horizontalInterval,
          ),
          titlesData: FlTitlesData(
            bottomTitles: SideTitles(
              showTitles: true,
              margin: 12.0,
              rotateAngle: 270.0,
              interval: verticalInterval,
              reservedSize: labelSize,
              textStyle: AppTextStyles.extraSmallLight,
              getTitles: (value) => timelineData[value.toInt()].date,
            ),
            leftTitles: SideTitles(
              showTitles: true,
              margin: 8.0,
              interval: horizontalInterval,
              reservedSize: labelSize,
              textStyle: AppTextStyles.extraSmallLight,
              getTitles: (value) => value.toInt().toString(),
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border(
              bottom: BorderSide(
                color: AppColors.primary,
                width: 1,
              ),
              left: BorderSide(
                color: AppColors.primary,
                width: 1,
              ),
              right: BorderSide(
                color: Colors.transparent,
              ),
              top: BorderSide(
                color: Colors.transparent,
              ),
            ),
          ),
          lineBarsData: [
            _buildLineData(
              xValues: xValues,
              yValues: timelineData
                  .map((data) => data.confirmed.toDouble())
                  .toList(),
              color: Colors.blue,
            ),
            _buildLineData(
              xValues: xValues,
              yValues: timelineData
                  .map((data) => data.recovered.toDouble())
                  .toList(),
              color: Colors.green,
            ),
            _buildLineData(
              xValues: xValues,
              yValues:
                  timelineData.map((data) => data.deaths.toDouble()).toList(),
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  LineChartBarData _buildLineData({
    List<double> xValues,
    List<double> yValues,
    Color color,
  }) {
    return LineChartBarData(
      spots: List<FlSpot>.generate(
        xValues.length,
        (index) => FlSpot(xValues[index], yValues[index]),
      ),
      isCurved: true,
      preventCurveOverShooting: true,
      barWidth: 1,
      isStrokeCapRound: true,
      dotData: FlDotData(show: false),
      colors: [
        color.withOpacity(0.7),
        color,
      ],
      colorStops: [0.0, 0.8],
      belowBarData: BarAreaData(
        show: true,
        colors: [
          color,
          color.withOpacity(0.6),
          color.withOpacity(0.3),
          color.withOpacity(0.0),
        ],
        gradientColorStops: [0.0, 0.5, 0.7, 1.0],
      ),
    );
  }
}
