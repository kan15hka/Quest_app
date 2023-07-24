import 'package:flutter/material.dart';
import 'package:quest/login/pages/auth_page.dart';
import 'package:quest/onboarding_screen/intro_page_1.dart';
import 'package:quest/onboarding_screen/intro_page_2.dart';
import 'package:quest/onboarding_screen/intro_page_3.dart';
import 'package:quest/onboarding_screen/style.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../constant.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController _controller = PageController();
  //keep track of if we are in last page or not
  bool onLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        //page view
        PageView(
          controller: _controller,
          onPageChanged: (index) {
            setState(() {
              onLastPage = (index == 2);
            });
          },
          children: [
            IntroPage1(),
            IntroPage2(),
            IntroPage3(),
          ],
        ),

        Container(
            alignment: Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //skip
                GestureDetector(
                    onTap: () {
                      _controller.jumpToPage(2);
                    },
                    child: Text('Skip', style: textStyleButton)),
                //dot indicators
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: WormEffect(
                      dotColor: kTitleTextBlueColor,
                      activeDotColor: kTitleTextPurpleColor),
                ),
                //next or done
                onLastPage
                    ? GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return AuthPage();
                          }));
                        },
                        child: Text('Done', style: textStyleButton))
                    : GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                              duration: Duration(milliseconds: 400),
                              curve: Curves.easeIn);
                        },
                        child: Text('Next', style: textStyleButton)),
              ],
            ))
      ],
    ));
  }
}
