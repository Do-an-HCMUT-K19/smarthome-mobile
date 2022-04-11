import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:smart_home/components/loading_box.dart';
import 'package:smart_home/constants/color.dart';
import 'package:smart_home/constants/menu_options.dart';
import 'package:smart_home/constants/room_type.dart';
import 'package:smart_home/screens/dashboard_holder.dart';
import 'package:smart_home/screens/dashboard-screens/livingroom_dashboard.dart';
import 'package:smart_home/screens/timer-screens/timer_screen.dart';
import 'package:smart_home/constants/smart_home_icon_icons.dart';
import 'package:smart_home/screens/timer_holder.dart';
import 'package:smart_home/states/main_bottom_bar.dart';
import 'package:smart_home/states/statistic_state.dart';
import 'package:smart_home/states/timer_state.dart';

class PopUpOptionMenu extends StatelessWidget {
  const PopUpOptionMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (_) {
        return <PopupMenuEntry<MenuOptions>>[
          PopupMenuItem(
            child: Row(
              children: const [
                Icon(Icons.add_chart_sharp),
                Text('Dashboard'),
              ],
            ),
            value: MenuOptions.dashboard,
          ),
          PopupMenuItem(
            child: Row(
              children: const [
                Icon(Icons.alarm),
                Text('Timer'),
              ],
            ),
            value: MenuOptions.statistic,
          ),
        ];
      },
      icon: const Icon(
        SmartHomeIcon.dashboard,
        color: Colors.white,
      ),
      onSelected: (value) async {
        context.read<BottomBarState>().changePage(0);
        if (MenuOptions.dashboard == value) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => DashboardScreen()));
        } else {
          Future<void> future = context.read<TimerState>().initValue();
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => FutureBuilder(
                    builder: (ctx, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return TimerHolder();
                      } else {
                        return Scaffold(
                          backgroundColor: darkPrimary,
                          body: const LoadingBox(),
                        );
                      }
                    },
                    // future: future,
                  )));
        }
      },
    );
  }
}
