import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/outh/signin_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});
  static String screenRoot = 'splash_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
          backgroundColor: Colors.white,
          splashIconSize: 400,
          splashTransition: SplashTransition.scaleTransition,
          pageTransitionType: PageTransitionType.topToBottom,
          splash: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 150,
            child: Lottie.asset(
              'lottei/Animation - 1716373076758.json',
            ),
          ),
          nextScreen: SigninScreen()),
    );
  }
}
