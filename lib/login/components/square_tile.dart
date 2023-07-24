import 'package:flutter/material.dart';
import 'package:quest/constant.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;
  final Function()? onTap;
  const SquareTile({
    super.key,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            border: Border.all(color: kTitleTextBlueColor),
            borderRadius: BorderRadius.circular(16.0),
            color: kSecondaryColor,
            backgroundBlendMode: BlendMode.color),
        child: Image.asset(
          imagePath,
          height: 35.0,
        ),
      ),
    );
  }
}
