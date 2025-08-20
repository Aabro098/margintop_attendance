// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:margintop_attendance/common/reusables/loading_indicator.dart';
import 'package:margintop_attendance/common/reusables/text_dialog.dart';
import 'package:margintop_attendance/common/widgets/attendance_report.dart';
import 'package:margintop_attendance/common/widgets/clock_widget.dart';
import 'package:margintop_attendance/common/widgets/heading_title.dart';
import 'package:margintop_attendance/common/widgets/time_info.dart';
import 'package:margintop_attendance/services/attendance_services.dart';
import 'package:margintop_attendance/utils/constants/app_strings.dart';
import 'package:margintop_attendance/utils/constants/sizes.dart';
import 'package:margintop_attendance/utils/device/device_utility.dart';
import 'package:margintop_attendance/utils/helpers/helper_functions.dart';
import 'package:margintop_attendance/utils/providers/attendance_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selected = "Home";
  bool _isLoading = false;
  bool _isAbsent = false;
  final TextEditingController _workController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();

  Future<void> _checkIn() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }
    try {
      String status;
      if (selected == "Home") {
        status = "present";
      } else if (selected == "Office") {
        status = "remote";
      } else {
        showErrorSnackbar("Select valid option.", context: context);
        return;
      }
      final response =
          await AttendanceServices().checkIn(context: context, status: status);
      if (response != null) {
        if (response['message'] == "Success" && response['status'] == 1) {
          showSuccessSnackbar(
              "Check in successfull. Hope you have a wonderful day workmate.",
              context: context);
        } else {
          showErrorSnackbar(response['message'], context: context);
        }
      } else {
        showErrorSnackbar(AppStrings.error, context: context);
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

  Future<void> _checkOut() async {
    if (_workController.text.trim().isEmpty) {
      showErrorSnackbar("Your work details cannot be empty.", context: context);
      return;
    }
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }
    try {
      final response = await AttendanceServices().checkOut(
        context: context,
        workSummary: _workController.text.trim(),
      );
      if (response != null) {
        if (response['message'] == "Success" && response['status'] == 1) {
          showSuccessSnackbar(
              "Check out successfull. Hope you had a wonderful day workmate.",
              context: context);
        } else {
          showErrorSnackbar(response['message'], context: context);
        }
      } else {
        showErrorSnackbar(AppStrings.error, context: context);
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

  Future<void> _absent() async {
    if (_workController.text.trim().isEmpty) {
      showErrorSnackbar("Your absent reason cannot be empty.",
          context: context);
      return;
    }
    if (mounted) {
      setState(() {
        _isAbsent = true;
      });
    }
    try {
      final response = await AttendanceServices().absent(
        context: context,
        reason: _reasonController.text.trim(),
      );
      if (response != null) {
        if (response['message'] == "Success" && response['status'] == 1) {
          showErrorSnackbar(
              "We will miss you dear workmate. Hope to see you soon",
              context: context);
        } else {
          showErrorSnackbar(response['message'], context: context);
        }
      } else {
        showErrorSnackbar(AppStrings.error, context: context);
      }
    } catch (e) {
      showErrorSnackbar(AppStrings.error, context: context);
    } finally {
      if (mounted) {
        setState(() {
          _isAbsent = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _workController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

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
          const SizedBox(height: AppSizes.md),

          // Welcome text
          Padding(
            padding: const EdgeInsets.only(
                left: AppSizes.padding, right: AppSizes.padding),
            child: AutoSizeText(
              "Welcome, Arbin Shrestha",
              style: theme.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSizes.padding),
              child: Column(
                children: [
                  Consumer<AttendanceProvider>(
                      builder: (context, provider, child) {
                    return Container(
                      padding: const EdgeInsets.all(AppSizes.padding),
                      decoration: BoxDecoration(
                        color: isDarkMode ? Colors.white10 : Colors.white,
                        borderRadius: BorderRadius.circular(AppSizes.lg),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: AppSizes.lg,
                            offset: Offset(0, 4),
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          _isLoading
                              ? const Center(child: LoadingIndicator())
                              : Row(
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
                                      isCheckIn: provider.checkIn,
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
                                      isCheckIn: provider.checkIn,
                                    ),
                                  ],
                                ),
                          const SizedBox(height: AppSizes.formHeight),
                          const RealTimeClock(),
                          const SizedBox(height: AppSizes.formHeight),
                          _isLoading
                              ? const LoadingIndicator()
                              : SizedBox(
                                  width: 172,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: provider.checkIn != null
                                          ? Colors.red
                                          : theme.colorScheme.primary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(AppSizes.lg),
                                      ),
                                    ),
                                    onPressed: () async {
                                      if (provider.checkIn == null) {
                                        _checkIn();
                                      } else {
                                        final dialog = StylishInputDialog(
                                          context: context,
                                          title:
                                              'Write in short about your day, dear workmate.',
                                          hintText: 'Write something...',
                                          controller: _workController,
                                          onSubmit: () {
                                            _checkOut();
                                          },
                                        );

                                        await dialog.show();
                                      }
                                    },
                                    child: Text(
                                      provider.checkIn != null
                                          ? provider.checkOut != null
                                              ? "Done"
                                              : "Check Out"
                                          : "Check In",
                                    ),
                                  ),
                                ),
                          const SizedBox(height: AppSizes.formHeight),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TimeInfo(
                                  time: provider.checkIn ?? "--",
                                  label: "Check In"),
                              TimeInfo(
                                  time: provider.checkOut ?? "--",
                                  label: "Check Out"),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),

                  const SizedBox(height: AppSizes.formHeight),

                  // Attendance
                  const AttendanceReport(),

                  const SizedBox(height: AppSizes.formHeight),

                  // Request Button
                  Consumer<AttendanceProvider>(
                      builder: (context, provider, child) {
                    return provider.checkIn != null
                        ? const SizedBox.shrink()
                        : SizedBox(
                            width: 172,
                            child: _isAbsent
                                ? const Center(
                                    child: LoadingIndicator(),
                                  )
                                : OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      side: const BorderSide(color: Colors.red),
                                    ),
                                    onPressed: () async {
                                      final dialog = StylishInputDialog(
                                        context: context,
                                        title:
                                            'Please provide the reason for the leave.',
                                        hintText: 'Write something...',
                                        controller: _workController,
                                        onSubmit: () {
                                          _absent();
                                        },
                                      );
                                      await dialog.show();
                                    },
                                    child: Text(
                                      "Absent",
                                      style:
                                          theme.textTheme.titleLarge?.copyWith(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                          );
                  }),
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
    required String? isCheckIn,
  }) {
    return GestureDetector(
      onTap: isCheckIn != null ? null : onTap,
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
