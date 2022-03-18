import 'package:flutter/material.dart';
import 'package:smart_home/constants/color.dart';

class MySlider extends StatefulWidget {
  double value;
  double lowerBound;
  double upperBound;
  double cautionBound;
  Function callBack;
  MySlider({
    required this.value,
    required this.lowerBound,
    required this.upperBound,
    required this.cautionBound,
    required this.callBack,
  });
  @override
  State<MySlider> createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  var isChange = false;
  var tempValue = 0.0;

  @override
  void initState() {
    super.initState();
    tempValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          Text(
            '${widget.value.round().toInt()}%',
            style: TextStyle(
              color: Colors.white,
              fontSize: 60,
            ),
          ),
          Slider(
            max: 40,
            min: 5,
            value: widget.value,
            onChanged: (value) {
              isChange = true;
              widget.value = value;
              setState(() {});
            },
            activeColor: cold,
          ),
          const SizedBox(
            height: 50,
          ),
          if (isChange)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    isChange = false;
                    widget.callBack(widget.value.round().toDouble());
                    tempValue = widget.value;
                  },
                  child: Container(
                      height: 70,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: activeCircle,
                          width: 2,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: Container(
                              height: 70,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(360),
                                gradient: RadialGradient(
                                  radius: 0.75,
                                  colors: [
                                    Colors.white.withOpacity(0.3),
                                    Colors.white.withOpacity(0.1),
                                    Colors.white.withOpacity(0.01),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Confirm',
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    isChange = false;
                    widget.value = tempValue;
                    setState(() {});
                  },
                  child: Container(
                    height: 70,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: activeCircle,
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }
}
