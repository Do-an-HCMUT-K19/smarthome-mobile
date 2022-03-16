import 'package:flutter/material.dart';
import 'package:smart_home/constants/info_type.dart';

class InfoDisplay extends StatelessWidget {
  final Info type;
  final int data;
  const InfoDisplay({
    required this.type,
    required this.data,
    Key? key,
  }) : super(key: key);

  String getUnit() {
    return type == Info.temperature ? '°C' : '%';
  }

  String getLabel() {
    if (type == Info.light) {
      return 'Light';
    } else if (type == Info.temperature) {
      return 'Temperature';
    }
    return 'Humidity';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          getLabel(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          '$data' + getUnit(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 35,
          ),
        )
      ],
    );
  }
}
