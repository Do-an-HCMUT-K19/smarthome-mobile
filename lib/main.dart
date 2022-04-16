import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/constants/color.dart';
import 'package:smart_home/screens/main_holder.dart';
import 'package:smart_home/states/bathroom.dart';
import 'package:smart_home/states/bedroom.dart';
import 'package:smart_home/states/garden.dart';
import 'package:smart_home/states/kitchen.dart';
import 'package:smart_home/states/light_statistic.dart';
import 'package:smart_home/states/livingroom.dart';
import 'package:smart_home/states/main_bottom_bar.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:smart_home/states/statistic_state.dart';
import 'package:smart_home/states/timer_state.dart';
import 'conf/firebase_conf.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Channel',
  description: 'Description',
  importance: Importance.high,
  playSound: true,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(message) async {
  await Firebase.initializeApp();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      FirebaseMessaging.onBackgroundMessage(
          _firebaseMessagingBackgroundHandler);

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
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
      ),
      ChangeNotifierProvider(
        create: (_) => LightStatistic(),
      ),
    ],
    child: SmartHome(),
  ));
}

class SmartHome extends StatelessWidget {
  SmartHome({Key? key}) : super(key: key) {
    FirebaseMessaging.onMessage.listen(
      (event) {
        RemoteNotification? notification = event.notification;
        AndroidNotification? android = event.notification?.android;

        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                color: primary,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(child: MainHolder()),
    );
  }
}
