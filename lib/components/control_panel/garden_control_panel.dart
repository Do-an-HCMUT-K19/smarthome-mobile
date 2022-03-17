import 'package:flutter/material.dart';
import 'package:smart_home/components/light_control.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/components/my_slider.dart';
import 'package:smart_home/constants/color.dart';
import 'package:smart_home/constants/info_type.dart';
import 'package:smart_home/states/garden.dart';

import '../../smart_home_icon_icons.dart';
import '../func_button.dart';
import '../info_display.dart';

class GardenControl extends StatefulWidget {
  @override
  State<GardenControl> createState() => _GardenControlState();
}

class _GardenControlState extends State<GardenControl> {
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
            darkPrimary.withOpacity(0.5),
            darkPrimary.withOpacity(0.1),
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
                  data: context.watch<GardenState>().temp.toInt().toInt()),
              InfoDisplay(type: Info.light, data: 31),
              InfoDisplay(
                  type: Info.humidity,
                  data: context.watch<GardenState>().humid.toInt())
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
                  chosing = 0;
                  setState(() {});
                },
                child: FuncButton(
                  isActive: chosing == 0,
                  icon: SmartHomeIcon.light,
                  label: 'Light',
                ),
              ),
              if (context.read<GardenState>().isControlHumid)
                GestureDetector(
                  onTap: () {
                    chosing = 1;
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                LightControl(
                  order: 0,
                  isActive: context.read<GardenState>().getLightState(0),
                  callBack: context.read<GardenState>().changeLightState,
                ),
                LightControl(
                  order: 1,
                  isActive: context.read<GardenState>().getLightState(1),
                  callBack: context.read<GardenState>().changeLightState,
                ),
              ],
            ),
          if (chosing == 1)
            MySlider(
              value: context.read<GardenState>().humid,
              lowerBound: 5,
              upperBound: 50,
              cautionBound: 40,
              callBack: context.read<GardenState>().changeHumidity,
            ),
          // humid controller
        ],
      ),
    );
  }
}
