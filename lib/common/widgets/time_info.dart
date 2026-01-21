import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:margintop_solutions/common/reusables/small_container.dart';
import 'package:margintop_solutions/utils/constants/sizes.dart';

class TimeInfo extends StatefulWidget {
  final String time;
  final IconData icon;

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
    final theme = Theme.of(context);
    return Column(
      children: [
        widget.time.isEmpty
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (index) => Padding(
                    padding:
                        const EdgeInsets.only(right: 6), // spacing between dots
                    child: SmallDots(),
                  ),
                ),
              )
            : AutoSizeText(
                widget.time,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
        const SizedBox(height: AppSizes.md),
        Icon(
          widget.icon,
          size: 28,
          color: theme.colorScheme.primary,
        ),
      ],
    );
  }
}
