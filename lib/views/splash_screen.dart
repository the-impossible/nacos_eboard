import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:nacos_eboard/components/delegatedText.dart';
import 'package:nacos_eboard/services/constants.dart';
import 'package:nacos_eboard/views/auth/signIn.dart';
import 'package:page_transition/page_transition.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedSplashScreen(
        splashIconSize: 300,
        centered: true,
        duration: 1000,
        splashTransition: SplashTransition.scaleTransition,
        pageTransitionType: PageTransitionType.fade,
        animationDuration: const Duration(
          seconds: 1,
        ),
        nextScreen: const SignIn(),
        backgroundColor: Constants.secondaryColor,
        splash: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                "assets/logo.png",
                width: 200,
                height: 150,
              ),
              DelegatedText(
                text: 'e-Notice Board',
                fontSize: 40,
                fontName: 'sub',
                color: Constants.tertiaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
