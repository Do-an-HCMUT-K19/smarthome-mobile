import 'package:flutter/material.dart';
import 'package:smart_home/components/func_button.dart';
import 'package:smart_home/components/info_display.dart';
import 'package:smart_home/components/light_bulbs_panel.dart';
import 'package:smart_home/components/my_slider.dart';
import 'package:smart_home/constants/color.dart';
import 'package:smart_home/constants/info_type.dart';
import 'package:smart_home/smart_home_icon_icons.dart';

class ControlPanel extends StatefulWidget {
  ControlPanel({Key? key}) : super(key: key);

  @override
  State<ControlPanel> createState() => _ControlPanelState();
}

class _ControlPanelState extends State<ControlPanel> {
  int chosing = 0;
  double tempValue = 20;
  double humidValue = 30;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height * 0.7,
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
            darkPrimary,
            darkPrimary,
            darkPrimary.withOpacity(0.74),
            darkPrimary.withOpacity(0.04),
          ],
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InfoDisplay(type: Info.temperature, data: tempValue.toInt()),
              InfoDisplay(type: Info.light, data: 31),
              InfoDisplay(type: Info.humidity, data: humidValue.toInt())
            ],
          ),
          SizedBox(
            height: 10,
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
                  icon: SmartHomeIcon.temperature,
                  label: 'Temp',
                ),
              ),
              GestureDetector(
                onTap: () {
                  chosing = 1;
                  setState(() {});
                },
                child: FuncButton(
                  isActive: chosing == 1,
                  icon: SmartHomeIcon.light,
                  label: 'Light',
                ),
              ),
              GestureDetector(
                onTap: () {
                  chosing = 2;
                  setState(() {});
                },
                child: FuncButton(
                  isActive: chosing == 2,
                  icon: SmartHomeIcon.colorize,
                  label: 'Humid',
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          if (chosing == 0)
            MySlider(
              value: tempValue,
              lowerBound: 0,
              upperBound: 40,
              cautionBound: 35,
            ),
          if (chosing == 1) LightPanel(),
          if (chosing == 2)
            MySlider(
              value: humidValue,
              lowerBound: 10,
              upperBound: 50,
              cautionBound: 25,
            ),
        ],
      ),
    );
  }
}
