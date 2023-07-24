import 'package:flutter/material.dart';
import 'package:quest/constant.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  const MyButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20.0),
        margin: EdgeInsets.symmetric(horizontal: 25.0),
        decoration: BoxDecoration(
          color: kSecondaryColor,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: kTitleTextBlueColor, width: 2.0),
        ),
        child: Center(
          child: Text(text,
              style: TextStyle(
                  color: kTitleTextBlueColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  fontFamily: font)),
        ),
      ),
    );
  }
}
