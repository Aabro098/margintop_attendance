import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:margintop_solutions/extensions/extensions.dart';
import 'package:margintop_solutions/utils/constants/app_strings.dart';
import 'package:margintop_solutions/utils/constants/sizes.dart';
import 'package:margintop_solutions/utils/helpers/helper_functions.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AttendanceReport extends StatefulWidget {
  const AttendanceReport({super.key});

  @override
  State<AttendanceReport> createState() => _AttendanceReportState();
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
      // final response =
      //     await AttendanceServices().getSummaryMonth(year: year, month: month);

      // if (response.status == 1 && response.message == "Success") {
      //   if (mounted) {
      //     setState(() {
      //       present = response.data.summary.presentDays +
      //           response.data.summary.remoteDays;
      //       absent = response.data.summary.absentDays;
      //       totalHours = response.data.summary.totalHours;
      //     });
      //   }
      // }
    } catch (e) {
      showErrorSnackbar(AppStrings.error);
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
    return Container(
      padding: const EdgeInsets.all(AppSizes.md),
      decoration: BoxDecoration(
        color: context.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          AutoSizeText(
            "Attendance for this month",
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSizes.formHeight),
          Skeletonizer(
            enabled: _isLoading,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _buildAttendanceCard(
                    "Present",
                    present != null ? present.toString() : "0",
                    Colors.green,
                  ),
                ),
                const SizedBox(
                  width: AppSizes.sm,
                ),
                Expanded(
                  child: _buildAttendanceCard(
                    "Absent",
                    absent != null ? absent.toString() : "0",
                    Colors.red,
                  ),
                ),
                const SizedBox(
                  width: AppSizes.sm,
                ),
                Expanded(
                  child: _buildAttendanceCard(
                    "Work Hour",
                    totalHours != null ? totalHours.toString() : "0",
                    Colors.orange,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceCard(String title, String count, Color color) {
    return Container(
      height: 92,
      padding: const EdgeInsets.all(AppSizes.sm),
      decoration: BoxDecoration(
        color: color.withAlpha(24),
        borderRadius: BorderRadius.circular(AppSizes.sm),
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
              fontWeight: FontWeight.bold,
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
