import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:smart_home/components/bottom_bar.dart';
import 'package:smart_home/constants/room_type.dart';
import 'package:smart_home/models/timer.dart';
import 'package:smart_home/screens/timer-screens/timer_screen.dart';
import 'package:smart_home/states/main_bottom_bar.dart';

class TimerHolder extends StatelessWidget {
  const TimerHolder({Key? key}) : super(key: key);
  final _pages = const [
    TimerScreen(roomType: RoomType.livingRoom),
    TimerScreen(roomType: RoomType.bedRoom),
    TimerScreen(roomType: RoomType.bathRoom),
    TimerScreen(roomType: RoomType.kitChen),
    TimerScreen(roomType: RoomType.garden),
  ];
  @override
  Widget build(BuildContext context) {
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
      body: _pages[context.watch<BottomBarState>().chosenPage],
    );
  }
}
