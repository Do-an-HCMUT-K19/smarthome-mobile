import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:smart_home/components/popup_menu.dart';
import 'package:smart_home/constants/color.dart';
import 'package:smart_home/constants/menu_options.dart';
import 'package:smart_home/screens/dashboard-screens/dashboard_screen.dart';
import 'package:smart_home/smart_home_icon_icons.dart';
import 'package:smart_home/states/main_bottom_bar.dart';

class WelcomBar extends StatelessWidget {
  const WelcomBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height * 0.15,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            darkPrimary,
            darkPrimary.withOpacity(0.9),
            darkPrimary.withOpacity(0.5),
            darkPrimary.withOpacity(0.05)
          ],
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 20),
          Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Welcome home,',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Hoang',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ]),
          ),
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: const PopUpOptionMenu(),
          )
        ],
      ),
    );
  }
}
