import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:covid19_info/core/models/timeline_data.dart';

import 'package:fl_chart/fl_chart.dart';

class MinTimelineGraph extends StatelessWidget {
  final List<TimelineData> timeline;

  const MinTimelineGraph({
    @required this.timeline,
  }) : assert(timeline != null);

  @override
  Widget build(BuildContext context) {
    final double maxY =
        timeline.map((e) => e.cases).reduce(math.max).toDouble();
    final List<double> xValues =
        timeline.map((data) => timeline.indexOf(data).toDouble()).toList();

    return LineChart(
      LineChartData(
        minX: 0.0,
        minY: 0.0,
        maxY: maxY,
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          _buildLineData(
            xValues: xValues,
            yValues: timeline.map((data) => data.cases.toDouble()).toList(),
            color: Colors.lightBlue,
          ),
          _buildLineData(
            xValues: xValues,
            yValues: timeline.map((data) => data.recovered.toDouble()).toList(),
            color: Colors.lightGreen,
          ),
          _buildLineData(
            xValues: xValues,
            yValues: timeline.map((data) => data.deaths.toDouble()).toList(),
            color: Colors.redAccent,
          ),
        ],
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
      barWidth: 2,
      isStrokeCapRound: true,
      dotData: FlDotData(show: false),
      colors: [color],
      aboveBarData: BarAreaData(show: false),
      belowBarData: BarAreaData(
        show: true,
        colors: [
          color.withOpacity(0.6),
          color.withOpacity(0.4),
          color.withOpacity(0.2),
          color.withOpacity(0.0),
        ],
        gradientColorStops: [0.0, 0.3, 0.6, 0.9],
      ),
    );
  }
}
