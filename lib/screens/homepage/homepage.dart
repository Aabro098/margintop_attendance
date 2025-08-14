// ignore_for_file: deprecated_member_use

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:margintop_attendance/common/widgets/attendance_report.dart';
import 'package:margintop_attendance/common/widgets/clock_widget.dart';
import 'package:margintop_attendance/common/widgets/heading_title.dart';
import 'package:margintop_attendance/common/widgets/time_info.dart';
import 'package:margintop_attendance/utils/constants/sizes.dart';
import 'package:margintop_attendance/utils/device/device_utility.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selected = "Home";
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = DeviceUtility.isDarkMode(context);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const HeadingTitle(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSizes.padding),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(AppSizes.padding),
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.white10 : Colors.white,
                      borderRadius: BorderRadius.circular(AppSizes.lg),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: AppSizes.lg,
                            offset: Offset(0, 4))
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildToggleButton(
                              text: "Home",
                              icon: Iconsax.home_1,
                              selected: selected == "Home",
                              onTap: () {
                                setState(() => selected = "Home");
                              },
                              theme: theme,
                            ),
                            const SizedBox(width: 8),
                            _buildToggleButton(
                              text: "Office",
                              icon: Iconsax.building,
                              selected: selected == "Office",
                              onTap: () {
                                setState(() => selected = "Office");
                              },
                              theme: theme,
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSizes.formHeight),
                        const RealTimeClock(),
                        const SizedBox(height: AppSizes.formHeight),
                        SizedBox(
                          width: 172,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(AppSizes.lg),
                              ),
                            ),
                            onPressed: () {},
                            child: const Text(
                              "Check In",
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSizes.formHeight),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TimeInfo(time: "10:00 AM", label: "Check In"),
                            TimeInfo(time: "06:30 PM", label: "Check Out"),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: AppSizes.formHeight),

                  // Attendance
                  const AttendanceReport(),

                  const SizedBox(height: AppSizes.formHeight),

                  // Request Button
                  SizedBox(
                    width: 172,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        side: const BorderSide(color: Colors.red),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Absent",
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton({
    required String text,
    required IconData icon,
    required bool selected,
    required ThemeData theme,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? theme.colorScheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            color: theme.colorScheme.primary,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: selected ? Colors.white : theme.colorScheme.primary,
              size: AppSizes.iconSm,
            ),
            const SizedBox(
              width: 8,
            ),
            AutoSizeText(
              text,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: selected ? Colors.white : theme.colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
