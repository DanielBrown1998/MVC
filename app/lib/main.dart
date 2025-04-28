import 'package:app/screens/dashboard.dart';
import 'package:flutter/material.dart';
// import 'package:app/screens/dashboard.dart';
import 'package:app/screens/splash.dart';

void main() {
  runApp(const Grimorio());
}

class Grimorio extends StatelessWidget {
  const Grimorio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Grimório",
      theme: ThemeData.dark(useMaterial3: true),
      initialRoute: '/',
      routes: {
        "/": (context) => SplashScreen(),
        "home": (context) => Dashboard(),
      },
    );
  }
}
