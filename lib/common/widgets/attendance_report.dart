import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:margintop_solutions/extensions/extensions.dart';
import 'package:margintop_solutions/utils/constants/sizes.dart';
import 'package:margintop_solutions/utils/providers/attendance_provider.dart';
import 'package:provider/provider.dart';

class AttendanceReport extends StatefulWidget {
  const AttendanceReport({super.key});

  @override
  State<AttendanceReport> createState() => _AttendanceReportState();
}

class _AttendanceReportState extends State<AttendanceReport> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AttendanceProvider>(builder: (
      context,
      provider,
      child,
    ) {
      return Container(
        padding: const EdgeInsets.all(AppSizes.md),
        decoration: BoxDecoration(
          color: context.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: context.colorScheme.primary.withAlpha(102),
          ),
        ),
        child: Column(
          children: [
            AutoSizeText(
              "Attendance report for this month",
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppSizes.sm),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _buildAttendanceCard(
                    "Present",
                    provider.presentDays.toString(),
                    Colors.green,
                  ),
                ),
                const SizedBox(
                  width: AppSizes.sm,
                ),
                Expanded(
                  child: _buildAttendanceCard(
                    "Absent",
                    provider.absentDays.toString(),
                    Colors.red,
                  ),
                ),
                const SizedBox(
                  width: AppSizes.sm,
                ),
                Expanded(
                  child: _buildAttendanceCard(
                    "Work Hour",
                    provider.totalHours.toString(),
                    Colors.orange,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _buildAttendanceCard(String title, String count, Color color) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.sm),
      decoration: BoxDecoration(
        color: color.withAlpha(24),
        borderRadius: BorderRadius.circular(AppSizes.sm),
        border: Border.all(
          color: color.withAlpha(152),
        ),
        boxShadow: [
          BoxShadow(
            color: color.withAlpha(20),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        children: [
          AutoSizeText(
            title,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.titleMedium?.copyWith(
              color: color,
            ),
          ),
          const SizedBox(height: AppSizes.sm),
          AutoSizeText(
            count,
            style: context.textTheme.titleLarge?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
