import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:margintop_solutions/common/reusables/small_container.dart';
import 'package:margintop_solutions/extensions/extensions.dart';
import 'package:margintop_solutions/utils/constants/sizes.dart';

class TimeInfo extends StatefulWidget {
  final String time;
  final String icon;

  const TimeInfo({
    super.key,
    required this.time,
    required this.icon,
  });

  @override
  State<TimeInfo> createState() => _TimeInfoState();
}

class _TimeInfoState extends State<TimeInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(
        widget.time.isNotEmpty ? AppSizes.sm : AppSizes.md,
      ),
      decoration: BoxDecoration(
        color: context.colorScheme.primary.withAlpha(24),
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
        border: Border.all(
          color: context.colorScheme.primary.withAlpha(152),
        ),
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.primary.withAlpha(28),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        children: [
          widget.time.isEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (index) => Padding(
                      padding: const EdgeInsets.only(
                          right: 6), // spacing between dots
                      child: SmallDots(),
                    ),
                  ),
                )
              : AutoSizeText(
                  widget.time,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
          const SizedBox(height: AppSizes.sm),
          AutoSizeText(
            widget.icon,
            style: context.textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}
