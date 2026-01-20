// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:margintop_solutions/common/reusables/custom_button.dart';
import 'package:margintop_solutions/common/widgets/absent.dart';
import 'package:margintop_solutions/common/widgets/attendance_report.dart';
import 'package:margintop_solutions/common/widgets/clock_widget.dart';
import 'package:margintop_solutions/common/widgets/heading_title.dart';
import 'package:margintop_solutions/common/widgets/time_info.dart';
import 'package:margintop_solutions/extensions/extensions.dart';
import 'package:margintop_solutions/screens/Homepage/checkout_details.dart';
import 'package:margintop_solutions/services/attendance_services.dart';
import 'package:margintop_solutions/utils/constants/app_strings.dart';
import 'package:margintop_solutions/utils/constants/colors_light.dart';
import 'package:margintop_solutions/utils/constants/image_strings.dart';
import 'package:margintop_solutions/utils/constants/sizes.dart';
import 'package:margintop_solutions/utils/helpers/app_globals.dart';
import 'package:margintop_solutions/utils/helpers/helper_functions.dart';
import 'package:margintop_solutions/utils/providers/attendance_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selected;
  bool _isLoading = false;
  bool _networkError = false;
  String? name;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeName();
      final provider = context.read<AttendanceProvider>();
      selected = provider.location ?? "Home";
      provider.isFirst ? _getStatus() : null;
    });
  }

  Future<void> _initializeName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final storedName = prefs.getString('name');
    if (mounted) {
      setState(() {
        name = storedName;
      });
    }
  }

  Future<void> _checkIn() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }
    try {
      String status;
      if (selected == "Home") {
        status = "remote";
      } else if (selected == "Office") {
        status = "present";
      } else {
        showErrorSnackbar(
          "Select valid option.",
        );
        return;
      }

      final response = await AttendanceServices().checkIn(
        context: context,
        status: status,
      );
      if (response != null) {
        if (response['message'] == "Success" && response['status'] == 1) {
          showSuccessSnackbar(
            "Check in successfull. Hope you have a wonderful day workmate.",
          );
        } else {
          showErrorSnackbar(
            response['message'],
          );
        }
      } else {
        showErrorSnackbar(
          AppStrings.error,
        );
      }
    } catch (e) {
      showErrorSnackbar(
        AppStrings.error,
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _getStatus() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }
    try {
      final provider = context.read<AttendanceProvider>();
      final response = await AttendanceServices().getStatus();

      // if (response.message == "Success" && response.status == 1) {
      //   // If there’s at least one record, pick the first one
      //   if (response.data.isNotEmpty) {
      //     final attendance = response.data.first;

      //     String? checkIn = attendance.checkInTime;
      //     String? checkOut =
      //         attendance.checkOutTime; // fixed: was using checkIn before
      //     String? status = attendance.status;
      //     if (status == "absent") {
      //       provider.updateStatus(isAbsent: true);
      //     } else if (status == "remote") {
      //       selected = "Home";
      //       await provider.updateStatus(location: "Home");
      //     } else if (status == "present") {
      //       selected = "Office";
      //       await provider.updateStatus(location: "Office");
      //     }

      //     if (checkIn != null) {
      //       provider.updateStatus(checkIn: formatToTime(checkIn));
      //     }

      //     if (checkOut != null) {
      //       provider.updateStatus(checkOut: formatToTime(checkOut));
      //     }
      //   }

      // provider.first = false;
      // } else {
      //   showErrorSnackbar(
      //     response.message,
      //   );
      // }
    } catch (e) {
      if (mounted) {
        setState(() {
          _networkError = true;
        });
      }
      showErrorSnackbar(
        AppStrings.error,
      );
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
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const HeadingTitle(),
            Skeletonizer(
              enabled: _isLoading,
              enableSwitchAnimation: true,
              child: _nameTitle(),
            ),
            RefreshIndicator(
              color: context.colorScheme.primary,
              onRefresh: () {
                return _getStatus();
              },
              child: Skeletonizer(
                enabled: _isLoading,
                enableSwitchAnimation: true,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.padding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Consumer<AttendanceProvider>(
                          builder: (context, provider, child) {
                            return Container(
                              padding: const EdgeInsets.all(AppSizes.padding),
                              decoration: BoxDecoration(
                                color: context.colorScheme.primaryContainer,
                                borderRadius:
                                    BorderRadius.circular(AppSizes.lg),
                              ),
                              child: provider.isAbsent
                                  ? Lottie.asset(
                                      AppLogos.sadRobot,
                                      repeat: true,
                                      height: 160,
                                      width: double.infinity,
                                    )
                                  : Column(
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            _buildToggleButton(
                                              text: "Home",
                                              icon: Iconsax.home_1,
                                              selected: selected == "Home",
                                              onTap: _isLoading
                                                  ? null
                                                  : () {
                                                      if (mounted) {
                                                        setState(() =>
                                                            selected = "Home");
                                                      }
                                                    },
                                              isCheckIn: provider.checkIn,
                                            ),
                                            const SizedBox(width: 12),
                                            _buildToggleButton(
                                              text: "Office",
                                              icon: Iconsax.building,
                                              selected: selected == "Office",
                                              onTap: _isLoading
                                                  ? null
                                                  : () {
                                                      if (mounted) {
                                                        setState(() =>
                                                            selected =
                                                                "Office");
                                                      }
                                                    },
                                              isCheckIn: provider.checkIn,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: AppSizes.lg),
                                        const RealTimeClock(),
                                        const SizedBox(height: AppSizes.lg),
                                        _attendanceButton(provider),
                                        const SizedBox(height: AppSizes.xl),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TimeInfo(
                                              time: provider.checkIn ??
                                                  '11:00 AM',
                                              icon: Iconsax.timer_start,
                                            ),
                                            TimeInfo(
                                              time: provider.checkOut ??
                                                  '5:00 AM',
                                              icon: Iconsax.timer_pause,
                                            ),
                                            TimeInfo(
                                              time: provider.checkOut ??
                                                  '6:00 Hrs',
                                              icon: Iconsax.clock,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                            );
                          },
                        ),

                        const SizedBox(height: AppSizes.md),

                        // Attendance
                        const AttendanceReport(),

                        // Absent Button
                        const AbsentButton(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox _attendanceButton(AttendanceProvider provider) {
    return SizedBox(
      width: 236,
      child: CustomElevatedButton(
        isLoading: _isLoading,
        color: provider.checkIn != null
            ? Colors.green
            : context.colorScheme.primary,
        onPressed: () async {
          if (provider.checkIn == null) {
            await _checkIn();
          } else if (provider.checkIn != null && provider.checkOut == null) {
            navigatorKey.currentState?.push(
              MaterialPageRoute(
                builder: (context) => const CheckoutDetails(),
              ),
            );
          } else {
            null;
          }
        },
        label: provider.checkIn != null
            ? provider.checkOut != null
                ? "Done"
                : "Check Out"
            : "Check In",
      ),
    );
  }

  Widget _nameTitle() {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.padding),
      child: Center(
        child: AutoSizeText(
          "Welcome, $name !",
          style: context.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: context.isDarkMode
                ? context.colorScheme.primary
                : AppColorsLight.logoColor,
          ),
        ),
      ),
    );
  }

  Widget _buildToggleButton({
    required String text,
    required IconData icon,
    required bool selected,
    required VoidCallback? onTap,
    required String? isCheckIn,
  }) {
    return GestureDetector(
      onTap: isCheckIn != null ? null : onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? context.colorScheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: context.colorScheme.primary),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: selected ? Colors.white : context.colorScheme.primary,
              size: AppSizes.iconSm,
            ),
            const SizedBox(width: AppSizes.md),
            AutoSizeText(
              text,
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: selected ? Colors.white : context.colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
