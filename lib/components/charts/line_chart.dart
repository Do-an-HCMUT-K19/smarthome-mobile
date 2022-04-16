import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:smart_home/constants/chart_type.dart';

class LineChartSample2 extends StatefulWidget {
  final ChartType chartType;
  List<FlSpot> data;
  double maxX;
  LineChartSample2({
    Key? key,
    required this.chartType,
    required this.data,
    required this.maxX,
  }) : super(key: key);

  @override
  _LineChartSample2State createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.75,
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
              color: Color(0xff232d37),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 18.0, left: 12.0, top: 24, bottom: 12),
              child: LineChart(
                mainData(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0xff68737d),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          getTitles: (value) {
            if (value.toInt() % 6 == 0) {
              return (value.toInt()).toString();
            }
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
            fontSize: 13,
          ),
          getTitles: (value) {
            String unit =
                widget.chartType == ChartType.temperature ? '°C' : '%';
            if (widget.chartType == ChartType.temperature && value % 10 == 0) {
              return value.toInt().toString() + unit;
            } else if ((widget.chartType == ChartType.land_humidity ||
                    widget.chartType == ChartType.air_humidity) &&
                value % 20 == 0) {
              return value.toInt().toString() + unit;
            }
            return '';
          },
          reservedSize: 32,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(
          color: const Color(0xff37434d),
          width: 1,
        ),
      ),
      minX: 0,
      maxX: widget.maxX,
      minY: 0,
      maxY: widget.chartType == ChartType.temperature ? 40 : 100,
      lineBarsData: [
        LineChartBarData(
          spots: widget.data,
          isCurved: true,
          colors: gradientColors,
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.15)).toList(),
          ),
        ),
      ],
    );
  }
}
