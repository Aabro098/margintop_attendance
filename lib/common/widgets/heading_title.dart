import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:margintop_solutions/extensions/extensions.dart';
import 'package:margintop_solutions/utils/constants/image_strings.dart';
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                context.isDarkMode ? AppLogos.markDark : AppLogos.markWhite,
                height: 92,
                width: 92,
              ),
              // const SizedBox(width: AppSizes.sm),
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
            ],
          ),
          // AutoSizeText(
          //   "Diamond Marg, Lalitpur 44600",
          //   maxLines: null, // Allow unlimited lines
          //   softWrap: true, // Enable text wrapping
          //   overflow: TextOverflow.visible, // Show all text
          //   style: context.textTheme.titleSmall?.copyWith(
          //     color: context.colorScheme.primary,
          //   ),
          //   textAlign: TextAlign.center,
          // )
        ],
      ),
    );
  }
}
