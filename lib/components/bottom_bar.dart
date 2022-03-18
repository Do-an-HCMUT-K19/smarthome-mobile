import 'package:flutter/material.dart';
import 'package:smart_home/constants/color.dart';
import 'package:list_wheel_scroll_view_x/list_wheel_scroll_view_x.dart';

class BottomNavBar extends StatefulWidget {
  Function change;
  int selectedPage;
  BottomNavBar({
    Key? key,
    required this.change,
    required this.selectedPage,
  }) : super(key: key);
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  TextStyle getStyle(int selectedPage) {
    return TextStyle(
      color: widget.selectedPage == selectedPage
          ? Colors.white
          : Colors.grey.withOpacity(0.3),
      fontSize: 25,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      color: darkPrimary1,
      height: size.width * 0.2,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            const SizedBox(width: 110),
            GestureDetector(
              onTap: () {
                widget.selectedPage = 0;
                widget.change(0);
              },
              child: Container(
                child: Text('Living room', style: getStyle(0)),
                margin: EdgeInsets.symmetric(horizontal: 30),
              ),
            ),
            GestureDetector(
              onTap: () {
                widget.selectedPage = 1;
                widget.change(1);
              },
              child: Container(
                child: Text('Bedroom', style: getStyle(1)),
                margin: EdgeInsets.symmetric(horizontal: 30),
              ),
            ),
            GestureDetector(
              onTap: () {
                widget.selectedPage = 2;
                widget.change(2);
              },
              child: Container(
                child: Text('Bathroom', style: getStyle(2)),
                margin: EdgeInsets.symmetric(horizontal: 30),
              ),
            ),
            GestureDetector(
              onTap: () {
                widget.selectedPage = 3;
                widget.change(3);
              },
              child: Container(
                child: Text('Kitchen', style: getStyle(3)),
                margin: EdgeInsets.symmetric(horizontal: 30),
              ),
            ),
            GestureDetector(
              onTap: () {
                widget.selectedPage = 4;
                widget.change(4);
              },
              child: Container(
                child: Text('Garden', style: getStyle(4)),
                margin: EdgeInsets.symmetric(horizontal: 30),
              ),
            ),
            const SizedBox(width: 110),
          ],
        ),
      ),
    );
  }
}
