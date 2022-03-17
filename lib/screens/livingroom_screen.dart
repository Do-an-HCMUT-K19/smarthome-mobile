// import 'package:flutter/material.dart';
// import 'package:smart_home/components/control_panel.dart';
// import 'package:smart_home/components/cover_image.dart';
// import 'package:smart_home/components/welcome_bar.dart';
// import 'package:provider/provider.dart';
// import 'package:smart_home/states/kitchen.dart';
// import 'package:smart_home/states/livingroom.dart';

// class LivingroomScreen extends StatelessWidget {
//   const LivingroomScreen({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//       height: size.height,
//       child: Stack(
//         children: [
//           CoverImage(),
//           WelcomBar(),
//           Positioned(
//             child: ControlPanel(
//               isControlHumid: context.read<LivingRoomState>().isControlHumid,
//               isControlTemp: context.read<LivingRoomState>().isControlTemp,
//             ),
//             bottom: 0,
//           )
//         ],
//       ),
//     );
//   }
// }
