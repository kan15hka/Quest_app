import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quest/onboarding_screen/style.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: pageThreeColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset('assets/page3.json', height: 400.0),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'Quest exponentially increases the performance by conducting repeated tests and helping them analyze their performance profile',
              style: textStyleScreen,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 50.0,
          )
        ],
      ),
    );
  }
}
