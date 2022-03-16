import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:smart_home/constants/color.dart';

class MySlider extends StatefulWidget {
  double value;
  double lowerBound;
  double upperBound;
  double cautionBound;
  MySlider({
    required this.value,
    required this.lowerBound,
    required this.upperBound,
    required this.cautionBound,
  });
  @override
  State<MySlider> createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  var isChange = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          SleekCircularSlider(
              innerWidget: (value) => Center(
                    child: Text(
                      value.round().toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                      ),
                    ),
                  ),
              initialValue: widget.value,
              max: widget.upperBound,
              min: widget.lowerBound,
              key: GlobalKey(),
              appearance: CircularSliderAppearance(
                customWidths:
                    CustomSliderWidths(progressBarWidth: 15, trackWidth: 5),
                size: 300,
                angleRange: 180,
                startAngle: 180,
                customColors: CustomSliderColors(
                  trackColor: activeCircle,
                  dotColor: hot.withOpacity(0),
                  progressBarColors: [hot, cold],
                ),
              ),
              onChange: (double value) {
                isChange = true;
                widget.value = value;
              }),
        ],
      ),
    );
  }
}
