// ignore_for_file: deprecated_member_use

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:margintop_attendance/utils/constants/sizes.dart';
import 'package:margintop_attendance/utils/device/device_utility.dart';

class AttendanceReport extends StatefulWidget {
  const AttendanceReport({
    super.key,
  });

  @override
  State<AttendanceReport> createState() => _AttendanceReportState();

  static Widget _buildAttendanceCard(String title, String count, Color color) {
    return Container(
      width: 90,
      padding: const EdgeInsets.all(AppSizes.md),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(AppSizes.sm),
      ),
      child: Column(
        children: [
          AutoSizeText(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: AppSizes.sm,
          ),
          AutoSizeText(
            count,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _AttendanceReportState extends State<AttendanceReport> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = DeviceUtility.isDarkMode(context);
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.white12 : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 12, offset: Offset(0, 4))
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AutoSizeText(
                "Attendance for this Month",
                style: theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const Row(
                children: [
                  Text("APR", style: TextStyle(fontSize: 16)),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSizes.formHeight),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AttendanceReport._buildAttendanceCard(
                "Present",
                "13",
                Colors.green,
              ),
              AttendanceReport._buildAttendanceCard(
                "Absents",
                "02",
                Colors.red,
              ),
              AttendanceReport._buildAttendanceCard(
                "Working Hours",
                "04",
                Colors.orange,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
