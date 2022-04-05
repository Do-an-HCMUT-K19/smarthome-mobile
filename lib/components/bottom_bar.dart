import 'package:flutter/material.dart';
import 'package:smart_home/constants/color.dart';
import 'package:provider/provider.dart';
import 'package:smart_home/states/main_bottom_bar.dart';

class BottomNavBar extends StatefulWidget {
  BottomNavBar({
    Key? key,
  }) : super(key: key);
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  TextStyle getStyle(int selectedPage, BuildContext context) {
    return TextStyle(
      color: context.read<BottomBarState>().chosenPage == selectedPage
          ? Colors.white
          : Colors.grey.withOpacity(0.3),
      fontSize: 25,
    );
  }

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      color: darkPrimary1,
      height: size.width * 0.2,
      child: Center(
        child: ListView(
          controller: scrollController,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: [
            const SizedBox(width: 110),
            Center(
              child: GestureDetector(
                onTap: () async {
                  await scrollController.animateTo(0,
                      duration: Duration(milliseconds: 250),
                      curve: Curves.easeIn);
                  context.read<BottomBarState>().changePage(0);
                },
                child: Container(
                  child: Text('Living room', style: getStyle(0, context)),
                  margin: EdgeInsets.symmetric(horizontal: 30),
                ),
              ),
            ),
            Center(
              child: GestureDetector(
                onTap: () async {
                  await scrollController.animateTo(0.425 * size.width,
                      duration: Duration(milliseconds: 250),
                      curve: Curves.easeIn);
                  context.read<BottomBarState>().changePage(1);
                },
                child: Container(
                  child: Text('Bedroom', style: getStyle(1, context)),
                  margin: EdgeInsets.symmetric(horizontal: 30),
                ),
              ),
            ),
            Center(
              child: GestureDetector(
                onTap: () async {
                  await scrollController.animateTo(0.825 * size.width,
                      duration: Duration(milliseconds: 250),
                      curve: Curves.easeIn);
                  context.read<BottomBarState>().changePage(2);
                },
                child: Container(
                  child: Text('Bathroom', style: getStyle(2, context)),
                  margin: EdgeInsets.symmetric(horizontal: 30),
                ),
              ),
            ),
            Center(
              child: GestureDetector(
                onTap: () async {
                  await scrollController.animateTo(1.2 * size.width,
                      duration: Duration(milliseconds: 250),
                      curve: Curves.easeIn);
                  context.read<BottomBarState>().changePage(3);
                },
                child: Container(
                  child: Text('Kitchen', style: getStyle(3, context)),
                  margin: EdgeInsets.symmetric(horizontal: 30),
                ),
              ),
            ),
            Center(
              child: GestureDetector(
                onTap: () async {
                  await scrollController.animateTo(1.6 * size.width,
                      duration: Duration(milliseconds: 250),
                      curve: Curves.easeIn);
                  context.read<BottomBarState>().changePage(4);
                },
                child: Container(
                  child: Text('Garden', style: getStyle(4, context)),
                  margin: EdgeInsets.symmetric(horizontal: 30),
                ),
              ),
            ),
            const SizedBox(width: 120),
          ],
        ),
      ),
    );
  }
}
