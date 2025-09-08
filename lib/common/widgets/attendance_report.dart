// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:margintop_solutions/common/reusables/loading_animation.dart';
import 'package:margintop_solutions/services/attendance_services.dart';
import 'package:margintop_solutions/utils/constants/app_strings.dart';
import 'package:margintop_solutions/utils/constants/sizes.dart';
import 'package:margintop_solutions/utils/device/device_utility.dart';
import 'package:margintop_solutions/utils/helpers/helper_functions.dart';

class AttendanceReport extends StatefulWidget {
  const AttendanceReport({super.key});

  @override
  State<AttendanceReport> createState() => _AttendanceReportState();

  static Widget _buildAttendanceCard(String title, String count, Color color) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.sm),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
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
              fontSize: 13,
            ),
          ),
          const SizedBox(height: AppSizes.sm),
          AutoSizeText(
            count,
            style: TextStyle(
              fontSize: 18,
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
  bool _isLoading = false;
  int month = DateTime.now().month;
  int year = DateTime.now().year;

  int? present;
  int? absent;
  int? totalHours;
  @override
  void initState() {
    super.initState();
    _fetchSummary(month);
  }

  Future<void> _fetchSummary(int month) async {
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }
    try {
      final response =
          await AttendanceServices().getSummaryMonth(year: year, month: month);

      if (response.status == 1 && response.message == "Success") {
        if (mounted) {
          setState(() {
            present = response.data.summary.presentDays +
                response.data.summary.remoteDays;
            absent = response.data.summary.absentDays;
            totalHours = response.data.summary.totalHours;
          });
        }
      }
    } catch (e) {
      showErrorSnackbar(AppStrings.error, context: context);
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = DeviceUtility.isDarkMode(context);
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppSizes.md),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.white10 : Colors.white30,
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
                "Attendance for this month",
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              // CustomMonthDropdown(
              //   months: const [
              //     "JAN",
              //     "FEB",
              //     "MAR",
              //     "APR",
              //     "MAY",
              //     "JUN",
              //     "JUL",
              //     "AUG",
              //     "SEP",
              //     "OCT",
              //     "NOV",
              //     "DEC"
              //   ],
              //   initialMonth: const [
              //     "JAN",
              //     "FEB",
              //     "MAR",
              //     "APR",
              //     "MAY",
              //     "JUN",
              //     "JUL",
              //     "AUG",
              //     "SEP",
              //     "OCT",
              //     "NOV",
              //     "DEC"
              //   ][DateTime.now().month - 1], // current month
              // ),
            ],
          ),
          const SizedBox(height: AppSizes.formHeight),
          _isLoading
              ? const LoadingAnimation(height: 100, width: double.infinity)
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: AttendanceReport._buildAttendanceCard(
                        "Present",
                        present != null ? present.toString() : "0",
                        Colors.green,
                      ),
                    ),
                    const SizedBox(
                      width: AppSizes.sm,
                    ),
                    Expanded(
                      child: AttendanceReport._buildAttendanceCard(
                        "Absent",
                        absent != null ? absent.toString() : "0",
                        Colors.red,
                      ),
                    ),
                    const SizedBox(
                      width: AppSizes.sm,
                    ),
                    Expanded(
                      child: AttendanceReport._buildAttendanceCard(
                        "Work Hour",
                        totalHours != null ? totalHours.toString() : "0",
                        Colors.orange,
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
