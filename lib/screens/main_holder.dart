import 'package:provider/src/provider.dart';
import 'package:smart_home/components/bottom_bar.dart';
import 'package:smart_home/screens/main-screens/garden_screen.dart';
import 'package:flutter/material.dart';
import 'package:smart_home/states/main_bottom_bar.dart';

import 'main-screens/bathroom_screen.dart';
import 'main-screens/bedroom_screen.dart';
import 'main-screens/kitchen_screen.dart';
import 'main-screens/livingroom_screen.dart';

class MainHolder extends StatelessWidget {
  const MainHolder({Key? key}) : super(key: key);
  final pages = const [
    LivingroomScreen(),
    BedroomScreen(),
    BathroomScreen(),
    KitchenScreen(),
    GardenScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[context.watch<BottomBarState>().chosenPage],
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
