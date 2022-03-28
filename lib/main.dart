import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/components/bottom_bar.dart';
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
import 'package:smart_home/states/main_bottom_bar.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  print('testing');
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('\n\n\nSuccess\n\n\n');
    var a = await FirebaseFirestore.instance
        .collection('devices')
        .doc('QfgPfit0CczPBxW8goul')
        .get()
        .then((value) {
      print(value.data()!['ID'].toString());
    });
  } catch (e) {
    print(e);
  }
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
          body: pages[context.watch<BottomBarState>().chosenPage],
          bottomNavigationBar: BottomNavBar(),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
// import './firebase_utils.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );

//   var res =
//       await FirebaseUtils.getLastestRealtimeDatabase({'AccountName': 'giacat'});

//   var snapshot = res.data;

//   snapshot.listen((event) {
//     print(event.docs[0]["timestamp"].toDate());
//   });

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // Try running your application with "flutter run". You'll see the
//         // application has a blue toolbar. Then, without quitting the app, try
//         // changing the primarySwatch below to Colors.green and then invoke
//         // "hot reload" (press "r" in the console where you ran "flutter run",
//         // or simply save your changes to "hot reload" in a Flutter IDE).
//         // Notice that the counter didn't reset back to zero; the application
//         // is not restarted.
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Invoke "debug painting" (press "p" in the console, choose the
//           // "Toggle Debug Paint" action from the Flutter Inspector in Android
//           // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//           // to see the wireframe for each widget.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
