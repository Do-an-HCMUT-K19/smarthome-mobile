// import 'package:flutter/material.dart';
// import 'package:smart_home/dumb_data.dart';

// class LightPanel extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//       width: size.width * 0.8,
//       height: size.width * 0.75,
//       // child: ListView(
//       //   children: light_list,
//       // ),
//       child: GridView.builder(
//         itemCount: light_list.length,
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           mainAxisSpacing: 10,
//           crossAxisSpacing: 10,
//           childAspectRatio: 1.75,
//         ),
//         itemBuilder: (ctx, idx) {
//           return light_list[idx];
//         },
//       ),
//     );
//   }
// }
