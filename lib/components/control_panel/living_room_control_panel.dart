import 'package:flutter/material.dart';
import 'package:smart_home/components/light_control.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/components/my_slider.dart';
import 'package:smart_home/constants/color.dart';
import 'package:smart_home/constants/info_type.dart';
import 'package:smart_home/states/livingroom.dart';

import '../../smart_home_icon_icons.dart';
import '../func_button.dart';
import '../info_display.dart';

class LivingRoomControl extends StatefulWidget {
  @override
  State<LivingRoomControl> createState() => _LivingRoomControlState();
}

class _LivingRoomControlState extends State<LivingRoomControl> {
  int chosing = -1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // var lightList =
    return Container(
      width: size.width,
      height: size.height * 0.65,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            darkPrimary,
            darkPrimary,
            darkPrimary,
            darkPrimary,
            darkPrimary,
            darkPrimary,
            darkPrimary,
            darkPrimary,
            darkPrimary,
            darkPrimary,
            darkPrimary,
            darkPrimary,
            darkPrimary,
            darkPrimary.withOpacity(0.8),
            darkPrimary.withOpacity(0.7),
            darkPrimary.withOpacity(0),
          ],
        ),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InfoDisplay(
                  type: Info.temperature,
                  data: context.watch<LivingRoomState>().temp.toInt()),
              InfoDisplay(type: Info.light, data: 31),
              InfoDisplay(
                  type: Info.humidity,
                  data: context.watch<LivingRoomState>().humid.toInt())
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  chosing = chosing == 0 ? -1 : 0;
                  setState(() {});
                },
                child: FuncButton(
                  isActive: chosing == 0,
                  icon: SmartHomeIcon.light,
                  label: 'Light',
                ),
              ),
              if (context.read<LivingRoomState>().isControlHumid)
                GestureDetector(
                  onTap: () {
                    chosing = chosing == 1 ? -1 : 1;
                    setState(() {});
                  },
                  child: FuncButton(
                    isActive: chosing == 1,
                    icon: SmartHomeIcon.colorize,
                    label: 'Humid',
                  ),
                ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          if (chosing == 0)
            // light controller
            Container(
              height: 250,
              width: 250,
              child: GridView.count(
                crossAxisSpacing: 20,
                mainAxisSpacing: 5,
                crossAxisCount: 2,
                children: [
                  LightControl(
                    order: 0,
                    isActive: context.read<LivingRoomState>().getLightState(0),
                    callBack: context.read<LivingRoomState>().changeLightState,
                  ),
                  LightControl(
                    order: 1,
                    isActive: context.read<LivingRoomState>().getLightState(1),
                    callBack: context.read<LivingRoomState>().changeLightState,
                  ),
                  LightControl(
                    order: 2,
                    isActive: context.read<LivingRoomState>().getLightState(2),
                    callBack: context.read<LivingRoomState>().changeLightState,
                  ),
                  LightControl(
                    order: 3,
                    isActive: context.read<LivingRoomState>().getLightState(3),
                    callBack: context.read<LivingRoomState>().changeLightState,
                  ),
                ],
              ),
            ),
          if (chosing == 1)
            MySlider(
              value: context.read<LivingRoomState>().humid,
              lowerBound: 5,
              upperBound: 50,
              cautionBound: 40,
              callBack: context.read<LivingRoomState>().changeHumidity,
            ),
          // humid controller
        ],
      ),
    );
  }
}
