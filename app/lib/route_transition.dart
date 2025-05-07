import 'package:flutter/material.dart';

Route sliderRouteTransition(
  Widget nextScreen, {
  Duration duration = const Duration(milliseconds: 1000),
  Curve curves = Curves.ease,
  Offset beginPsotion = const Offset(-1, 1),
}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => nextScreen,
    transitionDuration: duration,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      Animatable<Offset> tween = Tween(
        begin: beginPsotion,
        end: Offset.zero,
      ).chain(CurveTween(curve: curves));
      return SlideTransition(
        position: animation.drive(tween),
        child: nextScreen,
      );
    },
  );
}
