import 'package:flutter/material.dart';

import '../constants/constants.dart';

class CircleIcon extends StatelessWidget {
  const CircleIcon({
    super.key,
    this.color,
    this.radius,
    this.scale,
    required this.icon,
  });
  final double? radius;
  final Color? color;
  final double? scale;
  final String icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(radius ?? Dimens.s_6()),
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Color(0xffE6EAF4).withAlpha(90), // Shadow color
            spreadRadius: 2, // How wide the  shadow spreads
            blurRadius: 3, // How soft the shadow is
            offset: Offset(0, 3), // Shadow position (x, y)
          ),
        ],
      ),
      child: Image.asset(icon, scale: scale ?? 3.7),
    );
  }
}
