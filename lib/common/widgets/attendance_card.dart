import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:margintop_solutions/utils/constants/sizes.dart';
import 'package:margintop_solutions/utils/helpers/helper_functions.dart';

class AttendanceCard extends StatefulWidget {
  final DateTime date;
  final String checkIn;
  final String checkOut;
  final String workHour;
  final String status;

  const AttendanceCard({
    super.key,
    required this.date,
    required this.checkIn,
    required this.checkOut,
    required this.workHour,
    required this.status,
  });

  @override
  State<AttendanceCard> createState() => _AttendanceCardState();
}

class _AttendanceCardState extends State<AttendanceCard> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AutoSizeText(
              DateFormat('EEE, MMM d, yyyy').format(widget.date),
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.secondary,
                borderRadius: BorderRadius.circular(AppSizes.md),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.md,
                vertical: AppSizes.sm,
              ),
              child: AutoSizeText(
                widget.status,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: AppSizes.lg,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            details(
              theme,
              label: "Check In",
              value: formatToTime(widget.checkIn),
              color: Colors.green,
            ),
            details(
              theme,
              label: "Check Out",
              value: formatToTime(widget.checkOut),
              color: Colors.red,
            ),
            // details(
            //   theme,
            //   label: "Work Hour",
            //   value: widget.workHour,
            //   color: Colors.orange,
            // ),
          ],
        ),
      ],
    );
  }

  Widget details(ThemeData theme,
      {required String label, required String value, required Color color}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AutoSizeText(
          value,
          style: theme.textTheme.titleLarge
              ?.copyWith(fontWeight: FontWeight.bold, color: color),
        ),
        AutoSizeText(
          label,
          style: theme.textTheme.titleSmall,
        ),
      ],
    );
  }
}
