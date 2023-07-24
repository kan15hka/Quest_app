import 'package:flutter/material.dart';
import 'package:quest/constant.dart';
import 'package:quest/onboarding_screen/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _NavigateToOnBoardingScreen();
  }

  _NavigateToOnBoardingScreen() async {
    await Future.delayed(Duration(seconds: 3), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => OnBoardingScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSecondaryColor,
      body: Center(
        child: Image(
          image: AssetImage('assets/splash.gif'),
          height: 800.0,
        ),
      ),
    );
  }
}
