import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/components/add_timer_dialog.dart';
import 'package:smart_home/components/timer_tile.dart';
import 'package:smart_home/constants/color.dart';
import 'package:smart_home/states/timer.dart';

class LivingRoomTimer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: primary,
      width: size.width,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 30, bottom: 10),
            color: Colors.white,
            height: size.height * 0.3,
            width: size.width * 0.9,
          ),
          Container(
            height: size.height * 0.55,
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
                  ElevatedButton(
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
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0))),
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
