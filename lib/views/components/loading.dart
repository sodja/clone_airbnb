import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DefaultCupertinoWidget extends GetView {
  Color? color;
  DefaultCupertinoWidget({this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoActivityIndicator(
        radius: 15,
        color: color,
      ),
    );
  }
}
