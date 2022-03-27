import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:smart_home/components/bottom_bar.dart';
import 'package:smart_home/components/dashboard_welcom_bar.dart';
import 'package:smart_home/constants/color.dart';

class DashBoardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: darkPrimary,
      extendBodyBehindAppBar: true,
      bottomNavigationBar: BottomNavBar(),
      floatingActionButton: GestureDetector(
        onTap: () {
          showDatePicker(
              builder: (context, child) {
                return Theme(
                  data: ThemeData.dark().copyWith(
                    colorScheme: ColorScheme.dark(
                      onSurface: Colors.white,
                      primary: Colors.blue,
                      onPrimary: Colors.white,
                      surface: darkPrimary,
                    ),
                    dialogBackgroundColor: inActive,
                  ),
                  child: child!,
                );
              },
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now());
        },
        child: Container(
          width: 75,
          height: 75,
          child: Center(
            child: Icon(
              Icons.calendar_today,
              color: Colors.white,
              size: 40,
            ),
          ),
          decoration: BoxDecoration(
            color: darkPrimary.withOpacity(0.5),
            borderRadius: BorderRadius.circular(360),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [
                  darkPrimary,
                  darkPrimary.withOpacity(0.5),
                  darkPrimary.withOpacity(0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )),
            ),
            title: Text('Dashboard'),
            toolbarHeight: 100,
            floating: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((ctx, idx) {
              return lst[idx];
            }, childCount: lst.length),
          )
        ],
      ),
    );
  }
}

var lst = [
  const Center(
    child: Text(
      'Temperature',
      style: TextStyle(color: Colors.white, fontSize: 30),
    ),
  ),
  SizedBox(
    height: 20,
  ),
  LineChartSample2(),
  SizedBox(
    height: 50,
  ),
  Divider(
    height: 5,
    indent: 100,
    endIndent: 100,
    color: Colors.white.withOpacity(0.75),
  ),
  SizedBox(
    height: 50,
  ),
  const Center(
    child: Text(
      'Light',
      style: TextStyle(color: Colors.white, fontSize: 30),
    ),
  ),
  SizedBox(
    height: 20,
  ),
  LineChartSample2(),
  SizedBox(
    height: 50,
  ),
  Divider(
    height: 5,
    indent: 100,
    endIndent: 100,
    color: Colors.white.withOpacity(0.75),
  ),
  SizedBox(
    height: 50,
  ),
  const Center(
    child: Text(
      'Humidity',
      style: TextStyle(color: Colors.white, fontSize: 30),
    ),
  ),
  SizedBox(
    height: 20,
  ),
  LineChartSample2(),
  SizedBox(
    height: 100,
  ),
];
// Dash pattern line chart example

class LineChartSample2 extends StatefulWidget {
  const LineChartSample2({Key? key}) : super(key: key);

  @override
  _LineChartSample2State createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  bool showAvg = false;

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
                color: Color(0xff232d37)),
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 18.0, left: 12.0, top: 24, bottom: 12),
              child: LineChart(
                showAvg ? avgData() : mainData(),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 60,
          height: 34,
          child: TextButton(
            onPressed: () {
              setState(() {
                showAvg = !showAvg;
              });
            },
            child: Text(
              'avg',
              style: TextStyle(
                  fontSize: 12,
                  color:
                      showAvg ? Colors.white.withOpacity(0.5) : Colors.white),
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
              fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'MAR';
              case 5:
                return 'JUN';
              case 8:
                return 'SEP';
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
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '10k';
              case 3:
                return '30k';
              case 5:
                return '50k';
            }
            return '';
          },
          reservedSize: 32,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
          ],
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (context, value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'MAR';
              case 5:
                return 'JUN';
              case 8:
                return 'SEP';
            }
            return '';
          },
          margin: 8,
          interval: 1,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '10k';
              case 3:
                return '30k';
              case 5:
                return '50k';
            }
            return '';
          },
          reservedSize: 32,
          interval: 1,
          margin: 12,
        ),
        topTitles: SideTitles(showTitles: false),
        rightTitles: SideTitles(showTitles: false),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ],
          isCurved: true,
          colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)!,
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)!,
          ],
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(show: true, colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)!
                .withOpacity(0.1),
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)!
                .withOpacity(0.1),
          ]),
        ),
      ],
    );
  }
}
