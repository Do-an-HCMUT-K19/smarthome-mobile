import 'package:flutter/material.dart';

class CoverImage extends StatelessWidget {
  const CoverImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Image.asset(
        'assets/images/modern-home.jpg',
        fit: BoxFit.fill,
      ),
      height: size.height * 0.5,
      width: size.width,
    );
  }
}
