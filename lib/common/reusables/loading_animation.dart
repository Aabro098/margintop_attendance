import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:margintop_solutions/utils/constants/image_strings.dart';

class LoadingAnimation extends StatelessWidget {
  final double height;
  final double width;
  const LoadingAnimation(
      {super.key, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      AppLogos.paperPlane,
      width: width,
      height: height,
      repeat: true,
    );
  }
}
