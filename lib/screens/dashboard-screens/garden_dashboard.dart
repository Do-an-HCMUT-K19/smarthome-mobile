import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/src/provider.dart';
import 'package:smart_home/components/charts/line_chart.dart';
import 'package:smart_home/components/loading_box.dart';
import 'package:smart_home/constants/chart_type.dart';
import 'package:smart_home/constants/color.dart';
import 'package:smart_home/constants/room_type.dart';
import 'package:smart_home/states/garden.dart';
import 'package:smart_home/states/statistic_state.dart';

class GardenDashboard extends StatefulWidget {
  const GardenDashboard({Key? key}) : super(key: key);

  @override
  State<GardenDashboard> createState() => _GardenDashboardState();
}

class _GardenDashboardState extends State<GardenDashboard> {
  bool _isRebuild = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final futureData = _isRebuild
        ? Future(() => null)
        : context
            .read<StatisticState>()
            .renewData(RoomType.garden, DateTime.now());
    return FutureBuilder(
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return CustomScrollView(
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
                    ),
                  ),
                ),
                title: const Text('Dashboard'),
                toolbarHeight: 100,
                floating: true,
                elevation: 0,
                backgroundColor: Colors.transparent,
                actions: [
                  IconButton(
                    onPressed: () {
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
                        initialDate: context.read<StatisticState>().chosenDate,
                        firstDate: DateTime(2020),
                        lastDate: DateTime.now(),
                      ).then(
                        (value) {
                          if (value != null) {
                            _isRebuild = true;
                            context
                                .read<StatisticState>()
                                .renewData(RoomType.garden, value);
                          }
                        },
                      );
                    },
                    icon: const Icon(Icons.calendar_today),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    const SizedBox(height: 20),
                    const Center(
                      child: Text(
                        'Temperature',
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ),
                    const SizedBox(height: 20),
                    LineChartSample2(
                      chartType: ChartType.temperature,
                      data: context.watch<StatisticState>().tempData,
                      maxX: context.watch<StatisticState>().maxXTemp,
                    ),
                    const SizedBox(height: 100),
                    Divider(
                      height: 5,
                      indent: 100,
                      endIndent: 100,
                      color: Colors.white.withOpacity(0.75),
                    ),
                    const SizedBox(height: 50),
                    const Center(
                      child: Text(
                        'Air Humidity',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    LineChartSample2(
                      chartType: ChartType.air_humidity,
                      data: context.watch<StatisticState>().humidAirData,
                      maxX: context.watch<StatisticState>().maxXHumidAir,
                    ),
                    const SizedBox(height: 100),
                    Divider(
                      height: 5,
                      indent: 100,
                      endIndent: 100,
                      color: Colors.white.withOpacity(0.75),
                    ),
                    const SizedBox(height: 50),
                    const Center(
                      child: Text(
                        'Land Humidity',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    LineChartSample2(
                      chartType: ChartType.land_humidity,
                      data: context.watch<StatisticState>().humidLandData,
                      maxX: context.watch<StatisticState>().maxXHumidLand,
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return const LoadingBox();
        }
      },
      future: futureData,
    );
  }
}
