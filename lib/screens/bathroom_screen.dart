// import 'package:flutter/material.dart';
// import 'package:smart_home/components/control_panel.dart';
// import 'package:smart_home/components/cover_image.dart';
// import 'package:smart_home/components/welcome_bar.dart';
// import 'package:provider/provider.dart';
// import 'package:smart_home/states/bathroom.dart';
// import 'package:smart_home/states/bedroom.dart';
// import 'package:smart_home/states/kitchen.dart';
// import 'package:smart_home/states/livingroom.dart';

// class BathroomScreen extends StatelessWidget {
//   const BathroomScreen({
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
//               isControlHumid: context.read<BathRoomState>().isControlHumid,
//               isControlTemp: context.read<BathRoomState>().isControlTemp,
//             ),
//             bottom: 0,
//           )
//         ],
//       ),
//     );
//   }
// }
