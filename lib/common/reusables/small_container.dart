import 'dart:math';
import 'package:flutter/material.dart';

class SmallDots extends StatelessWidget {
  SmallDots({super.key});

  final List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.black,
    Colors.white,
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
