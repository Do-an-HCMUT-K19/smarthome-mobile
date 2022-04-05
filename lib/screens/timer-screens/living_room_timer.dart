import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/components/add_timer_dialog.dart';
import 'package:smart_home/components/bottom_bar.dart';
import 'package:smart_home/components/charts/bar_chart.dart';
import 'package:smart_home/components/timer_tile.dart';
import 'package:smart_home/constants/color.dart';
import 'package:smart_home/states/timer.dart';

class LivingRoomTimer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Thời gian sử dụng đèn (giờ)',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.black.withOpacity(0),
      ),
      body: Container(
        color: darkPrimary,
        width: size.width,
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.only(top: 20),
                height: size.height * 0.34,
                width: size.width * 0.9,
                child: Column(
                  children: [
                    SizedBox(height: size.height * 0.03),
                    BarChartSample3(),
                    TextButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (_) {
                              return const NewAlarmDialog();
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
                )),
            Container(
              height: size.height * 0.53,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: size.width,
                    ),
                    ...context
                        .watch<TimerState>()
                        .timerList
                        .map((e) => TimerTile(timer: e)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
