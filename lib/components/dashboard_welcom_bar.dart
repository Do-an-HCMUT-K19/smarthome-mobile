import 'package:flutter/material.dart';
import 'package:smart_home/constants/color.dart';
import 'package:smart_home/screens/dashboard-screens/dashboard_screen.dart';
import 'package:smart_home/smart_home_icon_icons.dart';
import 'package:smart_home/states/main_bottom_bar.dart';
import 'package:provider/provider.dart';

class DashBoardWelcomBar extends StatelessWidget {
  const DashBoardWelcomBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // return Container(
    //   width: size.width,
    //   height: size.height * 0.15,
    //   decoration: BoxDecoration(
    //     gradient: LinearGradient(
    //       begin: Alignment.topCenter,
    //       end: Alignment.bottomCenter,
    //       colors: [
    //         darkPrimary,
    //         darkPrimary.withOpacity(0.72),
    //         darkPrimary.withOpacity(0.4),
    //         darkPrimary.withOpacity(0)
    //       ],
    //     ),
    //   ),
    //   child: Row(
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: [
    //       IconButton(
    //         onPressed: () {
    //           context.read<BottomBarState>().changePage(0);
    //           Navigator.of(context).pop();
    //         },
    //         icon: Icon(
    //           Icons.arrow_back,
    //           color: Colors.white,
    //           size: 40,
    //         ),
    //       ),
    //       const SizedBox(width: 20),
    //     ],
    //   ),
    // );
    return SliverAppBar();
  }
}
