import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quest/onboarding_screen/style.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: pageTwoColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset('assets/page2.json', height: 400.0),
          SizedBox(
            height: 50.0,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'Quest creates a virtual interaction between teachers and students',
              style: textStyleScreen,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
