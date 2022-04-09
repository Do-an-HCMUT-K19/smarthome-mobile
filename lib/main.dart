import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/components/bottom_bar.dart';
import 'package:smart_home/utils/firebase_utils.dart';
import 'package:smart_home/screens/dashboard-screens/livingroom_dashboard.dart';
import 'package:smart_home/screens/main-screens/bathroom_screen.dart';
import 'package:smart_home/screens/main-screens/bedroom_screen.dart';
import 'package:smart_home/screens/main-screens/garden_screen.dart';
import 'package:smart_home/screens/main-screens/kitchen_screen.dart';
import 'package:smart_home/screens/main-screens/livingroom_screen.dart';
import 'package:smart_home/screens/main_holder.dart';
import 'package:smart_home/states/bathroom.dart';
import 'package:smart_home/states/bedroom.dart';
import 'package:smart_home/states/garden.dart';
import 'package:smart_home/states/kitchen.dart';
import 'package:smart_home/states/livingroom.dart';
import 'package:smart_home/states/main_bottom_bar.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smart_home/states/statistic_state.dart';
import 'package:smart_home/states/timer.dart';
import 'conf/firebase_conf.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } else {
      await Firebase.app();
    }
    print('\n\n\nSuccess\n\n\n');
  } catch (e) {
    print(e);
  }
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
      ChangeNotifierProvider(
        create: (_) => BottomBarState(),
      ),
      ChangeNotifierProvider(
        create: (_) => TimerState(),
      ),
      ChangeNotifierProvider(
        create: (_) => StatisticState(),
      )
    ],
    child: const SmartHome(),
  ));
}

class SmartHome extends StatelessWidget {
  const SmartHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(child: MainHolder()),
    );
  }
}
