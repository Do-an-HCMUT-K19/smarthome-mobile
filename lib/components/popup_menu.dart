import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:smart_home/constants/menu_options.dart';
import 'package:smart_home/screens/dashboard-screens/dashboard_screen.dart';
import 'package:smart_home/smart_home_icon_icons.dart';
import 'package:smart_home/states/main_bottom_bar.dart';

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
      onSelected: (value) {
        context.read<BottomBarState>().changePage(0);
        if (MenuOptions.dashboard == value) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => DashBoardScreen()));
        } else {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => DashBoardScreen()));
        }
      },
    );
  }
}
