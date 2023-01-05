import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LineGraph extends StatelessWidget {
  List<Color> gradientColors = [
    const Color.fromRGBO(10, 214, 102, 1),
    const Color.fromRGBO(153, 239, 191, 1),
  ];

  LineGraph(this.data1, this.data2, {Key? key}) : super(key: key);
  List<double> data1;
  List<double> data2;
  // X labels
  // y Labels
  // x max
  // y max

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.8,
      child: LineChart(
        mainData(),
      ),
    );
  }

  LineChartData mainData() {
    bool isEmpty1 = data1.isEmpty;
    bool isEmpty2 = data1.isEmpty;
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff747878),
            strokeWidth: 0.25,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff747878),
            strokeWidth: 0.25,
          );
        },
      ),
      titlesData: FlTitlesData(
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 12),
          getTitles: (value) {
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          getTitles: (value) {
            return value % 20 == 0 ? (value.toString()) : '';
          },
          reservedSize: 32,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: Color(0xff747878)),
          left: BorderSide(color: Color(0xff747878)),
          top: BorderSide(color: Colors.transparent),
          right: BorderSide(color: Colors.transparent),
        ),
      ),
      minX: 0,
      maxX: max(data1.length.toDouble(), data2.length.toDouble()),
      minY: min(isEmpty1 ? 0 : data1.reduce(min),
              isEmpty2 ? 0 : data2.reduce(min)) -
          1,
      maxY: max(isEmpty1 ? 0 : data1.reduce(max),
              isEmpty2 ? 0 : data2.reduce(max)) *
          1.5,
      lineBarsData: [
        LineChartBarData(
          spots: List.generate(data1.length, (index) {
            return FlSpot(index.toDouble(), data1[index].toDouble());
          }).toList(),
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
          // belowBarData: BarAreaData(
          //   show: true,
          //   colors:
          //       gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          // ),
        ),
        LineChartBarData(
          spots: List.generate(data2.length, (index) {
            return FlSpot(index.toDouble(), data2[index].toDouble());
          }).toList(),
          isCurved: true,
          colors: const [
            Color.fromRGBO(23, 234, 234, 1.0),
            Color.fromRGBO(121, 225, 225, 1.0)
          ],
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
          // belowBarData: BarAreaData(
          //   show: true,
          //   colors:
          //       gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          // ),
        ),
      ],
    );
  }
}
