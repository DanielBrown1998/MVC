import 'package:app/screens/dashboard.dart';
import "package:flutter/material.dart";
import './theme/theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double opacityImage = 0;
  int timeDelayed = 1; //second
  int timeAnimation = 1;

  awaitAndShow(int time) {
    Future.delayed(Duration(seconds: time)).then((value) {
      setState(() {
        opacityImage = 1;
      });
    });
  }

  awaitAndNextScreen() {
    Future.delayed(Duration(seconds: timeAnimation + timeDelayed + 1)).then((
      value,
    ) {
      Navigator.pushReplacementNamed(context, "home");
    });
  }

  @override
  void initState() {
    awaitAndShow(timeDelayed);
    super.initState();
    awaitAndNextScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.modalBackgroundGradient[2],
      body: Center(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Image.asset("assets/grimorio_1152.png", width: 300),
            ),
            AnimatedOpacity(
              duration: Duration(seconds: timeAnimation),
              opacity: opacityImage,
              curve: Curves.ease,
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Image.asset(
                  "assets/grimorio_titulo_1152.png",
                  width: 300,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
