import 'package:flutter/material.dart';
import 'package:quest/constant.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  const MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        style: TextStyle(color: kPrimaryColor, fontFamily: font),
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: kSecondaryColor, width: 3.0)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: kTitleTextPurpleColor)),
            fillColor: kTextFieldFillColor,
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: kPrimaryColor, fontFamily: font)),
      ),
    );
  }
}
