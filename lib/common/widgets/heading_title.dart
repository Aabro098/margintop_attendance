import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:margintop_solutions/extensions/extensions.dart';
import 'package:margintop_solutions/utils/constants/sizes.dart';

class HeadingTitle extends StatefulWidget {
  const HeadingTitle({
    super.key,
  });

  @override
  State<HeadingTitle> createState() => _HeadingTitleState();
}

class _HeadingTitleState extends State<HeadingTitle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.padding),
      // decoration: BoxDecoration(
      //   color: context.colorScheme.primaryContainer,
      //   borderRadius: const BorderRadius.only(
      //     bottomLeft: Radius.circular(36),
      //     bottomRight: Radius.circular(36),
      //   ),
      // ),
      child: Column(
        children: [
          AutoSizeText(
            "MarginTop\nSolutions",
            maxLines: null, // Allow unlimited lines
            softWrap: true, // Enable text wrapping
            overflow: TextOverflow.visible, // Show all text
            style: context.textTheme.headlineLarge?.copyWith(
              color: context.colorScheme.primary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: AppSizes.sm,
          ),
          AutoSizeText(
            "Diamond Marg, Lalitpur 44600",
            maxLines: null, // Allow unlimited lines
            softWrap: true, // Enable text wrapping
            overflow: TextOverflow.visible, // Show all text
            style: context.textTheme.titleMedium?.copyWith(
              color: context.colorScheme.primary,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
