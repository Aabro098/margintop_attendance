import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:margintop_solutions/utils/constants/sizes.dart';

class AttendanceCard extends StatefulWidget {
  final DateTime date;
  final Map<String, dynamic> attendanceData;

  const AttendanceCard({
    super.key,
    required this.date,
    required this.attendanceData,
  });

  @override
  State<AttendanceCard> createState() => _AttendanceCardState();
}

class _AttendanceCardState extends State<AttendanceCard> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final key =
        "${widget.date.year}-${widget.date.month.toString().padLeft(2, '0')}-${widget.date.day.toString().padLeft(2, '0')}";
    final data = widget.attendanceData[key];

    if (data == null) {
      return const AutoSizeText(
        "No data for this date",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.red,
          fontSize: 16,
        ),
        maxLines: null,
        overflow: TextOverflow.visible,
      );
    }

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
                color: Colors.green,
                borderRadius: BorderRadius.circular(AppSizes.md),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.md,
                vertical: AppSizes.sm,
              ),
              child: AutoSizeText(
                "Home",
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
              value: "10:30 AM",
              color: Colors.green,
            ),
            details(
              theme,
              label: "Check Out",
              value: "7:30 PM",
              color: Colors.red,
            ),
            details(
              theme,
              label: "Work Hour",
              value: "8",
              color: Colors.orange,
            ),
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
