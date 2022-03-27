import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:smart_home/constants/color.dart';

class LightControl extends StatefulWidget {
  final int order;
  bool isActive;
  Function callBack;
  LightControl({
    required this.order,
    required this.isActive,
    required this.callBack,
    Key? key,
  }) : super(key: key);

  @override
  State<LightControl> createState() => _LightControlState();
}

class _LightControlState extends State<LightControl> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          Text(
            'Bulb ${widget.order + 1}',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          FlutterSwitch(
            value: widget.isActive,
            activeColor: Colors.white70,
            inactiveColor: inActive,
            width: 55,
            height: 30,
            onToggle: (val) {
              widget.callBack(widget.order, val);
            },
          )
        ],
      ),
    );
  }
}
