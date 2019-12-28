import 'package:flutter/material.dart';

class PageEnterAnimation {
  PageEnterAnimation(this.controller)
      : imageIconSize =
            Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: controller,
          curve: Interval(0, 0.9, curve: Curves.elasticOut),
        )),
        titleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: controller,
                curve: Interval(0.3, 0.6, curve: Curves.easeIn))),
        textOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: controller,
                curve: Interval(0.6, 0.9, curve: Curves.easeIn))),
        fieldOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(
                parent: controller,
                curve: Interval(0.9, 1.0, curve: Curves.bounceIn)));
  final AnimationController controller;
  final Animation<double> imageIconSize;
  final Animation<double> titleOpacity;
  final Animation<double> textOpacity;
  final Animation<double> fieldOpacity;
}
