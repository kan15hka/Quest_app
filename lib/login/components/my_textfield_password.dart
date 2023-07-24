import 'package:flutter/material.dart';
import 'package:quest/constant.dart';

class MyTextFieldPassword extends StatefulWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  const MyTextFieldPassword(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText});

  @override
  State<MyTextFieldPassword> createState() => _MyTextFieldPasswordState();
}

class _MyTextFieldPasswordState extends State<MyTextFieldPassword> {
  bool passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        style: TextStyle(color: kPrimaryColor, fontFamily: font),
        controller: widget.controller,
        obscureText: passwordVisible,
        decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(
                passwordVisible ? Icons.visibility_off : Icons.visibility,
                color: kPrimaryColor,
              ),
              onPressed: () {
                setState(
                  () {
                    passwordVisible = !passwordVisible;
                  },
                );
              },
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: kSecondaryColor, width: 3.0)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: kTitleTextPurpleColor),
            ),
            fillColor: kTextFieldFillColor,
            filled: true,
            hintText: widget.hintText,
            hintStyle: TextStyle(color: kPrimaryColor, fontFamily: font)),
      ),
    );
  }
}
