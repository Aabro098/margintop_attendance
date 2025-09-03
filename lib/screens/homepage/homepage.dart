// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:margintop_solutions/common/reusables/shimmer.dart';
import 'package:margintop_solutions/common/reusables/text_dialog.dart';
import 'package:margintop_solutions/common/widgets/attendance_report.dart';
import 'package:margintop_solutions/common/widgets/clock_widget.dart';
import 'package:margintop_solutions/common/widgets/heading_title.dart';
import 'package:margintop_solutions/common/widgets/time_info.dart';
import 'package:margintop_solutions/screens/Homepage/checkout_details.dart';
import 'package:margintop_solutions/services/attendance_services.dart';
import 'package:margintop_solutions/utils/constants/app_strings.dart';
import 'package:margintop_solutions/utils/constants/colors_light.dart';
import 'package:margintop_solutions/utils/constants/image_strings.dart';
import 'package:margintop_solutions/utils/constants/sizes.dart';
import 'package:margintop_solutions/utils/device/device_utility.dart';
import 'package:margintop_solutions/utils/helpers/helper_functions.dart';
import 'package:margintop_solutions/utils/providers/attendance_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selected = "Home";
  bool _isLoading = false;
  bool _isAbsent = false;
  bool _networkError = false;
  final TextEditingController _reasonController = TextEditingController();

  String? name;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeName();
      final provider = context.read<AttendanceProvider>();
      provider.isFirst ? _getStatus() : null;
    });
  }

  Future<void> _initializeName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final storedName = prefs.getString('name') ?? '...';
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
        status = "present";
      } else if (selected == "Office") {
        status = "remote";
      } else {
        showErrorSnackbar("Select valid option.", context: context);
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
            context: context,
          );
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
    if (_reasonController.text.trim().isEmpty) {
      showErrorSnackbar(
        "Your absent reason cannot be empty.",
        context: context,
      );
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
            context: context,
          );
          _reasonController.clear();
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

  Future<void> _getStatus() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }
    try {
      final provider = context.read<AttendanceProvider>();
      final response = await AttendanceServices().getStatus();

      if (response.message == "Success" && response.status == 1) {
        // If there’s at least one record, pick the first one
        if (response.data.isNotEmpty) {
          final attendance = response.data.first;

          String? checkIn = attendance.checkInTime;
          String? checkOut =
              attendance.checkOutTime; // fixed: was using checkIn before
          String? status = attendance.status;

          if (status == "absent") {
            provider.updateStatus(isAbsent: true);
          } else if (status == "remote") {
            selected = "Home";
          } else if (status == "present") {
            selected = "Office";
          }

          if (checkIn != null) {
            provider.updateStatus(checkIn: formatToTime(checkIn));
          }

          if (checkOut != null) {
            provider.updateStatus(checkOut: formatToTime(checkOut));
          }
        }

        provider.first = false;
      } else {
        showErrorSnackbar(response.message, context: context);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _networkError = true;
        });
      }
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
  void dispose() {
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
          Padding(
            padding: const EdgeInsets.only(
              left: AppSizes.padding,
              right: AppSizes.padding,
            ),
            child: Center(
              child: AutoSizeText(
                "Welcome, $name !",
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isDarkMode
                      ? theme.colorScheme.primary
                      : AppColorsLight.logoColor,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: AppSizes.md,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: AppSizes.padding),
                child: Column(
                  children: [
                    Consumer<AttendanceProvider>(
                      builder: (context, provider, child) {
                        return Container(
                          padding: const EdgeInsets.all(AppSizes.padding),
                          decoration: BoxDecoration(
                            color: isDarkMode ? Colors.white10 : Colors.white30,
                            borderRadius: BorderRadius.circular(AppSizes.lg),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: AppSizes.lg,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: _networkError
                              ? Center(
                                  child: IconButton(
                                    onPressed: () async {
                                      await _getStatus();
                                    },
                                    icon: const Icon(Iconsax.refresh),
                                  ),
                                )
                              : provider.isAbsent
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
                                              theme: theme,
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
                                              theme: theme,
                                              isCheckIn: provider.checkIn,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: AppSizes.md),
                                        const RealTimeClock(),
                                        const SizedBox(height: AppSizes.md),
                                        _isLoading
                                            ? const ShimmerLoading(
                                                height: 42,
                                                width: 172,
                                              )
                                            : SizedBox(
                                                width: 172,
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor: provider
                                                                .checkIn !=
                                                            null
                                                        ? provider.checkOut !=
                                                                null
                                                            ? Colors.green
                                                            : Colors.red
                                                        : theme.colorScheme
                                                            .primary,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        AppSizes.md,
                                                      ),
                                                    ),
                                                  ),
                                                  onPressed: () async {
                                                    if (provider.checkIn ==
                                                        null) {
                                                      _checkIn();
                                                    } else if (provider
                                                                .checkIn !=
                                                            null &&
                                                        provider.checkOut ==
                                                            null) {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              const CheckoutDetails(),
                                                        ),
                                                      );
                                                    } else {
                                                      null;
                                                    }
                                                  },
                                                  child: Text(
                                                    provider.checkIn != null
                                                        ? provider.checkOut !=
                                                                null
                                                            ? "Done"
                                                            : "Check Out"
                                                        : "Check In",
                                                  ),
                                                ),
                                              ),
                                        const SizedBox(height: AppSizes.md),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            TimeInfo(
                                              time: provider.checkIn ?? "--",
                                              label: "Check In",
                                            ),
                                            TimeInfo(
                                              time: provider.checkOut ?? "--",
                                              label: "Check Out",
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

                    const SizedBox(height: AppSizes.lg),

                    // Request Button
                    Consumer<AttendanceProvider>(
                      builder: (context, provider, child) {
                        return provider.isAbsent
                            ? AutoSizeText(
                                "Hope to see you soon at work dear workmate !",
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.center,
                              )
                            : provider.checkIn != null
                                ? const SizedBox.shrink()
                                : SizedBox(
                                    width: 172,
                                    child: _isAbsent
                                        ? const ShimmerLoading(
                                            height: 42, width: 172)
                                        : ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  16,
                                                ),
                                              ),
                                            ),
                                            onPressed: () async {
                                              final dialog = StylishInputDialog(
                                                context: context,
                                                title:
                                                    'Please provide the reason for the leave.',
                                                hintText: 'Write something...',
                                                controller: _reasonController,
                                                onSubmit: () {
                                                  _absent();
                                                },
                                              );
                                              await dialog.show();
                                            },
                                            child: Text(
                                              "Absent",
                                              style: theme.textTheme.titleLarge
                                                  ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                  );
                      },
                    ),
                    const SizedBox(height: 72),
                  ],
                ),
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
    required VoidCallback? onTap,
    required String? isCheckIn,
  }) {
    return GestureDetector(
      onTap: isCheckIn != null ? null : onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? theme.colorScheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: theme.colorScheme.primary),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: selected ? Colors.white : theme.colorScheme.primary,
              size: AppSizes.iconSm,
            ),
            const SizedBox(width: 8),
            AutoSizeText(
              text,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: selected ? Colors.white : theme.colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
