import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/components/bottom_bar.dart';
import 'package:smart_home/screens/dashboard-screens/dashboard_screen.dart';
import 'package:smart_home/screens/main-screens/bathroom_screen.dart';
import 'package:smart_home/screens/main-screens/bedroom_screen.dart';
import 'package:smart_home/screens/main-screens/garden_screen.dart';
import 'package:smart_home/screens/main-screens/kitchen_screen.dart';
import 'package:smart_home/screens/main-screens/livingroom_screen.dart';
import 'package:smart_home/states/bathroom.dart';
import 'package:smart_home/states/bedroom.dart';
import 'package:smart_home/states/garden.dart';
import 'package:smart_home/states/kitchen.dart';
import 'package:smart_home/states/livingroom.dart';
import 'package:smart_home/states/main_bottom_bar.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  // print('testing');
  // WidgetsFlutterBinding.ensureInitialized();
  // try {
  //   await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  //   );
  //   print('\n\n\nSuccess\n\n\n');
  //   var a = await FirebaseFirestore.instance
  //       .collection('devices')
  //       .doc('QfgPfit0CczPBxW8goul')
  //       .get()
  //       .then((value) {
  //     print(value.data()!['ID'].toString());
  //   });
  // } catch (e) {
  //   print(e);
  // }
  // print("SJDAKHA");
  // Testing connection
  // FirebaseFirestore.instance
  //     .collection('devices')
  //     .doc("QfgPfit0CczPBxW8goul")
  //     .get()
  //     .then((value) {
  //   var temp = value.data()!['ID'].toString();
  //   print(temp);
  // });

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
      )
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
      print(page);
    });
  }

  final pages = [
    LivingroomScreen(),
    BedroomScreen(),
    BathroomScreen(),
    KitchenScreen(),
    GardenScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          // body: pages[context.watch<BottomBarState>().chosenPage],
          body: DashBoardScreen(),
          // bottomNavigationBar: BottomNavBar(),
        ),
      ),
    );
  }
}
