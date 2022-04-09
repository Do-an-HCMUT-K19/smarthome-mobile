import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:smart_home/components/bottom_bar.dart';
import 'package:smart_home/constants/color.dart';
import 'package:smart_home/screens/dashboard-screens/bathroom_dashboard.dart';
import 'package:smart_home/screens/dashboard-screens/bedroom_dashboard.dart';
import 'package:smart_home/screens/dashboard-screens/garden_dashboard.dart';
import 'package:smart_home/screens/dashboard-screens/kitchen_dashboard.dart';
import 'package:smart_home/screens/dashboard-screens/livingroom_dashboard.dart';
import 'package:smart_home/states/main_bottom_bar.dart';

class DashboardScreen extends StatelessWidget {
  final pages = const [
    LivingRoomDashboard(),
    BedRoomDashboard(),
    BathRoomDashboard(),
    KitchenDashboard(),
    GardenDashboard(),
  ];

  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkPrimary,
      extendBodyBehindAppBar: true,
      bottomNavigationBar: BottomNavBar(),
      body: pages[context.watch<BottomBarState>().chosenPage],
    );
  }
}
