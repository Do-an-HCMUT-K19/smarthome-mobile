import 'package:flutter/material.dart';
import 'package:smart_home/components/control_panel.dart';
import 'package:smart_home/components/cover_image.dart';
import 'package:smart_home/components/welcome_bar.dart';

class ControlScreen extends StatelessWidget {
  const ControlScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      child: Stack(
        children: [
          CoverImage(),
          WelcomBar(),
          Positioned(
            child: ControlPanel(),
            bottom: 0,
          )
        ],
      ),
    );
  }
}
