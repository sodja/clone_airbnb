import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class WBoxShadow extends GetView {
  double? width;
  double? height;
  EdgeInsetsGeometry? padding;
  EdgeInsetsGeometry? margin;
  Color? foreground;
  Color? background;
  double radius;
  Widget child;

  WBoxShadow({
    Key? key,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.foreground,
    this.background,
    required this.radius,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(radius),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12, blurRadius: 4, offset: Offset(0, 3))
            ]),
        child: child);
  }
}
