import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quest/onboarding_screen/style.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: pageOneColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset('assets/page1.json', height: 400.0),
          SizedBox(
            height: 30.0,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'Quest is a learning platform for students with a quest for knowledge',
              style: textStyleScreen,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
