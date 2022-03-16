import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_home/components/bottom_bar.dart';
import 'package:smart_home/components/info_display.dart';
import 'package:smart_home/components/light_bulbs_panel.dart';
import 'package:smart_home/components/light_control.dart';
import 'package:smart_home/components/welcome_bar.dart';
import 'package:smart_home/constants/color.dart';
import 'package:smart_home/constants/info_type.dart';
import 'package:smart_home/screens/control_screen.dart';

import 'components/control_panel.dart';
import 'components/cover_image.dart';
import 'components/func_button.dart';

void main() {
  runApp(MainApp());
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

  final pages = [
    ControlScreen(),
    ControlScreen(),
    ControlScreen(),
    ControlScreen(),
  ];
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
