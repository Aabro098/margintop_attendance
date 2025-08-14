import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:margintop_attendance/utils/constants/colors_light.dart';
import 'package:margintop_attendance/utils/constants/image_strings.dart';
import 'package:margintop_attendance/utils/constants/sizes.dart';

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
        color: theme.colorScheme.primary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: AppSizes.xl,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppLogos.markWhite,
                // ignore: deprecated_member_use
                color: AppColorsLight.logoColor,
                height: 72,
                width: 72,
              ),
              const SizedBox(
                width: AppSizes.sm,
              ),
              Expanded(
                child: AutoSizeText(
                  "MarginTop Solutions",
                  maxLines: null, // Allow unlimited lines
                  softWrap: true, // Enable text wrapping
                  overflow: TextOverflow.visible, // Show all text
                  style: theme.textTheme.headlineLarge?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.md),

          // Welcome text
          AutoSizeText(
            "Welcome! Arbin Shrestha",
            style: theme.textTheme.headlineSmall?.copyWith(
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: AppSizes.sm,
          )
        ],
      ),
    );
  }
}
