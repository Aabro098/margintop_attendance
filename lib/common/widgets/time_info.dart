import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:margintop_attendance/utils/constants/sizes.dart';

class TimeInfo extends StatefulWidget {
  final String time;
  final String label;

  const TimeInfo({
    super.key,
    required this.time,
    required this.label,
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
        AutoSizeText(
          widget.time,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppSizes.xs),
        AutoSizeText(
          widget.label,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
