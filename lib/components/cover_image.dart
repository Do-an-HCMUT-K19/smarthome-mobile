import 'package:flutter/material.dart';

class CoverImage extends StatelessWidget {
  final String imgUrl;
  const CoverImage({
    required this.imgUrl,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Image.asset(
        imgUrl,
        fit: BoxFit.fill,
      ),
      height: size.height * 0.5,
      width: size.width,
    );
  }
}
