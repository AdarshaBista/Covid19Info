import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:covid19_info/core/models/timeline_data.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:covid19_info/ui/styles/styles.dart';

class TimelineGraph extends StatelessWidget {
  final String title;
  final List<TimelineData> timeline;

  const TimelineGraph({
    @required this.title,
    @required this.timeline,
  })  : assert(title != null),
        assert(timeline != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Divider(height: 24.0),
        Flexible(
          child: Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.mediumLight,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          'spread over time',
          style: AppTextStyles.smallLight,
        ),
        const SizedBox(height: 20.0),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: _buildGraph(),
        ),
        const Divider(height: 8.0),
      ],
    );
  }

  LineChart _buildGraph() {
    final double labelSize = 32.0;
    final double maxX = timeline.length.toDouble();
    final double maxY =
        timeline.map((e) => e.confirmed).reduce(math.max).toDouble();

    final double verticalInterval = (maxX ~/ 5).toDouble();
    final double horizontalInterval = (maxY ~/ 5).toDouble();
    final List<double> xValues =
        timeline.map((data) => timeline.indexOf(data).toDouble()).toList();

    return LineChart(
      LineChartData(
        lineTouchData: LineTouchData(
          handleBuiltInTouches: true,
          touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: AppColors.background.withOpacity(0.7),
            fitInsideHorizontally: true,
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
            interval: verticalInterval,
            reservedSize: labelSize,
            textStyle: AppTextStyles.extraSmallLight,
            getTitles: (value) {
              int index = value.toInt();
              DateTime date = DateTime.parse(timeline[index].date);
              DateFormat formatter = DateFormat('MMMd');
              return formatter.format(date);
            },
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
            yValues: timeline.map((data) => data.confirmed.toDouble()).toList(),
            color: Colors.blue,
          ),
          _buildLineData(
            xValues: xValues,
            yValues: timeline.map((data) => data.recovered.toDouble()).toList(),
            color: Colors.green,
          ),
          _buildLineData(
            xValues: xValues,
            yValues: timeline.map((data) => data.deaths.toDouble()).toList(),
            color: Colors.red,
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
      colors: [
        color.withOpacity(0.3),
        color.withOpacity(0.7),
        color,
      ],
      colorStops: [0.0, 0.2, 0.6],
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
