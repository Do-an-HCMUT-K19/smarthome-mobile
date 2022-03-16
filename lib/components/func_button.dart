import 'package:flutter/material.dart';
import 'package:smart_home/constants/color.dart';

class FuncButton extends StatelessWidget {
  FuncButton({
    Key? key,
    required this.isActive,
    required this.label,
    required this.icon,
  }) : super(key: key);
  final bool isActive;
  final String label;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.3,
      height: size.width * 0.3,
      child: Stack(
        children: [
          Center(
            child: Container(
              width: size.width * 0.2,
              height: size.width * 0.2,
              decoration: BoxDecoration(
                border: Border.all(
                  color: isActive ? activeCircle : inActive,
                  width: 1.5,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(360),
              ),
            ),
          ),
          Center(
            child: AnimatedContainer(
              curve: Curves.easeInToLinear,
              duration: Duration(seconds: 1000),
              child: Container(
                width: isActive ? size.width * 0.3 : 0,
                height: isActive ? size.width * 0.3 : 0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(360),
                    gradient: RadialGradient(colors: [
                      Colors.white.withOpacity(0.2),
                      Colors.white.withOpacity(0.1),
                      Colors.white.withOpacity(0)
                    ])),
              ),
            ),
          ),
          Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isActive ? Colors.white : inActive,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '$label',
                style: TextStyle(
                  color: isActive ? Colors.white : inActive,
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
