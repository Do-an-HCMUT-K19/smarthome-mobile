import 'package:flutter/material.dart';
import 'package:smart_home/constants/color.dart';
import 'package:smart_home/screens/dashboard_screen.dart';
import 'package:smart_home/smart_home_icon_icons.dart';

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
            darkPrimary.withOpacity(0.72),
            darkPrimary.withOpacity(0.4),
            darkPrimary.withOpacity(0)
          ],
        ),
      ),
      child: Row(
        children: [
          SizedBox(width: 20),
          Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  return DashBoardScreen();
                }));
              },
              icon: Icon(
                SmartHomeIcon.dashboard,
                color: Colors.white,
              ),
            ),
            margin: EdgeInsets.all(30),
          )
        ],
      ),
    );
  }
}
