import 'dart:math';
import 'package:flutter/material.dart';
import 'package:margintop_solutions/utils/constants/colors_dark.dart';
import 'package:margintop_solutions/utils/constants/colors_light.dart';

class SmallDots extends StatelessWidget {
  SmallDots({super.key});

  final List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.orange,
    AppColorsLight.primary,
    AppColorsDark.primary,
  ];

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final color = colors[random.nextInt(colors.length)];

    return Container(
      width: 4,
      height: 4,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}
