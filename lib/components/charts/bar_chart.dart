import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/src/provider.dart';
import 'package:smart_home/constants/room_type.dart';
import 'package:smart_home/states/light_statistic.dart';

class _BarChart extends StatelessWidget {
  _BarChart({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: getBarGroups(),
        gridData: FlGridData(show: false),
        alignment: BarChartAlignment.spaceEvenly,
        maxY: 24,
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: const EdgeInsets.all(0),
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  TextStyle getTitlesStyle(BuildContext ctx, double num) {
    return const TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
  }

  String getTitles(double value) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
      case 1:
      case 2:
      case 3:
      case 4:
      case 5:
      case 6:
        text = DateFormat('E')
            .format(DateTime.now().subtract(Duration(days: 6 - value.toInt())));
        break;
      default:
        text = '';
        break;
    }
    return text;
  }

  String getTopTitles(double num) {
    if (num.toInt() == 0) return 'Thời gian sử dụng';
    return '';
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          getTextStyles: getTitlesStyle,
          showTitles: true,
          reservedSize: 30,
          getTitles: getTitles,
          interval: 1,
        ),
        leftTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        rightTitles: SideTitles(showTitles: false),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  final _barsGradient = [
    Colors.lightBlueAccent,
    Colors.greenAccent,
  ];
  List<int> data = [];
  List<BarChartGroupData> getBarGroups() {
    List<BarChartGroupData> dataGroups = [];
    for (int i = 0; i < data.length; i++) {
      dataGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: data[i].toDouble() / 3600,
              colors: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
      );
    }
    return dataGroups;
  }

  List<BarChartGroupData> get barGroups => [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
              toY: 8,
              colors: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              toY: 10,
              colors: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
              toY: 14,
              colors: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
              toY: 15,
              colors: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
              toY: 13,
              colors: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
              toY: 10,
              colors: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
      ];
}

class BarChartSample3 extends StatefulWidget {
  final RoomType roomType;
  const BarChartSample3({
    Key? key,
    required this.roomType,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => BarChartSample3State();
}

class BarChartSample3State extends State<BarChartSample3> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.7,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        color: const Color(0xff2c4260),
        child: Container(
          child: _BarChart(
              data:
                  context.read<LightStatistic>().getLightData(widget.roomType)),
          padding: EdgeInsets.only(top: 35),
        ),
      ),
    );
  }
}
