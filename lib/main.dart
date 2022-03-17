import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/components/bottom_bar.dart';
import 'package:smart_home/components/info_display.dart';
import 'package:smart_home/components/light_bulbs_panel.dart';
import 'package:smart_home/components/light_control.dart';
import 'package:smart_home/components/welcome_bar.dart';
import 'package:smart_home/constants/color.dart';
import 'package:smart_home/constants/info_type.dart';
import 'package:smart_home/screens/bathroom_screen.dart';
import 'package:smart_home/screens/bedroom_screen.dart';
import 'package:smart_home/screens/garden_screen.dart';
import 'package:smart_home/screens/kitchen_screen.dart';
import 'package:smart_home/screens/livingroom_screen.dart';
import 'package:smart_home/states/bathroom.dart';
import 'package:smart_home/states/bedroom.dart';
import 'package:smart_home/states/garden.dart';
import 'package:smart_home/states/kitchen.dart';
import 'package:smart_home/states/livingroom.dart';

import 'components/control_panel.dart';
import 'components/cover_image.dart';
import 'components/func_button.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => BathRoomState(),
      ),
      ChangeNotifierProvider(
        create: (_) => BedRoomState(),
      ),
      ChangeNotifierProvider(
        create: (_) => GardenState(),
      ),
      ChangeNotifierProvider(
        create: (_) => KitchenState(),
      ),
      ChangeNotifierProvider(
        create: (_) => LivingRoomState(),
      ),
    ],
    child: MainApp(),
  ));
}

class MainApp extends StatefulWidget {
  MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  var _selectedPage = 0;

  void changePage(int page) {
    setState(() {
      _selectedPage = page;
    });
  }

  final pages = [GardenScreen()];
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: pages[_selectedPage],
          bottomNavigationBar: BottomNavBar(
            change: changePage,
            selectedPage: _selectedPage,
          ),
        ),
      ),
    );
  }
}
