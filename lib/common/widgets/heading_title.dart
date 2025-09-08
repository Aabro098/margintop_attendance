import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
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
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSizes.padding),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(36),
          bottomRight: Radius.circular(36),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: AppSizes.lg,
          ),
          AutoSizeText(
            "MarginTop Solutions",
            maxLines: null, // Allow unlimited lines
            softWrap: true, // Enable text wrapping
            overflow: TextOverflow.visible, // Show all text
            style: theme.textTheme.headlineLarge?.copyWith(
              color: Colors.white,
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
            style: theme.textTheme.titleSmall?.copyWith(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
