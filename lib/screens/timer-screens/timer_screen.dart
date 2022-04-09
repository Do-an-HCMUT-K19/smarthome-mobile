import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/components/add_timer_dialog.dart';
import 'package:smart_home/components/bottom_bar.dart';
import 'package:smart_home/components/charts/bar_chart.dart';
import 'package:smart_home/components/timer_tile.dart';
import 'package:smart_home/constants/color.dart';
import 'package:smart_home/constants/room_type.dart';
import 'package:smart_home/states/timer.dart';

class TimerScreen extends StatelessWidget {
  final RoomType roomType;
  const TimerScreen({required this.roomType, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: darkPrimary,
      width: size.width,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 40),
            height: size.height * 0.36,
            width: size.width * 0.95,
            child: Column(
              children: [
                SizedBox(height: size.height * 0.03),
                BarChartSample3(roomType: roomType),
                TextButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return NewAlarmDialog(roomType: roomType);
                        });
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.add),
                      Container(
                        child: const Text('Add timer'),
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ],
                  ),
                  style: TextButton.styleFrom(primary: Colors.white),
                ),
              ],
            ),
          ),
          Container(
            height: size.height * 0.49,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: size.width,
                  ),
                  ...context.watch<TimerState>().getTimerList(roomType).map(
                        (e) => TimerTile(
                          timer: e,
                          roomType: roomType,
                        ),
                      ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
