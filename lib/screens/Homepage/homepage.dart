// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:margintop_solutions/common/reusables/custom_button.dart';
import 'package:margintop_solutions/common/widgets/absent.dart';
import 'package:margintop_solutions/common/widgets/attendance_report.dart';
import 'package:margintop_solutions/common/widgets/clock_widget.dart';
import 'package:margintop_solutions/common/widgets/heading_title.dart';
import 'package:margintop_solutions/common/widgets/time_info.dart';
import 'package:margintop_solutions/extensions/extensions.dart';
import 'package:margintop_solutions/screens/Homepage/checkout_details.dart';
import 'package:margintop_solutions/utils/constants/colors_dark.dart';
import 'package:margintop_solutions/utils/constants/enums.dart';
import 'package:margintop_solutions/utils/constants/image_strings.dart';
import 'package:margintop_solutions/utils/constants/sizes.dart';
import 'package:margintop_solutions/utils/helpers/app_globals.dart';
import 'package:margintop_solutions/utils/local_storage/user_prefs.dart';
import 'package:margintop_solutions/utils/providers/attendance_provider.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? name;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeName();
      context.read<AttendanceProvider>().initializeProvider();
    });
  }

  Future<void> _initializeName() async {
    final storedName = await UserPrefs().getName();
    if (mounted) {
      setState(() {
        name = storedName;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final fetchingStatus = context.watch<AttendanceProvider>().isFetchingStatus;
    final provider = context.read<AttendanceProvider>();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.padding),
        child: RefreshIndicator(
          color: context.colorScheme.primary,
          onRefresh: () {
            return context.read<AttendanceProvider>().initializeProvider();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const HeadingTitle(),
              Skeletonizer(
                enabled: fetchingStatus,
                enableSwitchAnimation: true,
                child: _nameTitle(),
              ),
              Skeletonizer(
                enabled: fetchingStatus,
                enableSwitchAnimation: true,
                child: Container(
                  padding: const EdgeInsets.all(AppSizes.padding),
                  decoration: BoxDecoration(
                    color: context.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(AppSizes.lg),
                    border: Border.all(
                      color: context.colorScheme.primary.withAlpha(102),
                    ),
                  ),
                  child: Column(
                    spacing: AppSizes.md,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildToggleButton(
                            text: "Home",
                            icon: Iconsax.home_1,
                            location: WorkLocation.home,
                            onTap: () =>
                                provider.toggleLocation(WorkLocation.home),
                          ),
                          const SizedBox(width: 12),
                          _buildToggleButton(
                            text: "Office",
                            icon: Iconsax.building,
                            location: WorkLocation.office,
                            onTap: () =>
                                provider.toggleLocation(WorkLocation.office),
                          ),
                        ],
                      ),
                      const RealTimeClock(),
                      _attendanceButton(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: AppSizes.md,
                        children: [
                          TimeInfo(
                            time: provider.checkIn ?? '',
                            icon: AppLogos.enter,
                            color: AppColorsDark.success,
                          ),
                          TimeInfo(
                            time: provider.checkOut ?? '',
                            icon: AppLogos.exit,
                            color: AppColorsDark.error,
                          ),
                          TimeInfo(
                            time: provider.checkOut ?? '',
                            icon: AppLogos.clock,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.md),
              Skeletonizer(
                enabled: fetchingStatus,
                enableSwitchAnimation: true,
                child: const AttendanceReport(),
              ),
              const SizedBox(height: AppSizes.md),
              Skeletonizer(
                enabled: fetchingStatus,
                enableSwitchAnimation: true,
                child: const AbsentButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _attendanceButton() {
    final provider = context.watch<AttendanceProvider>();
    final loading = provider.isLoading;
    return SizedBox(
      width: 236,
      child: CustomElevatedButton(
        isLoading: loading,
        color: provider.checkIn != null
            ? Colors.green
            : context.colorScheme.primary,
        onPressed: () async {
          if (provider.checkIn == null && provider.location != null) {
            await context
                .read<AttendanceProvider>()
                .userCheckIn(provider.location!);
          } else if (provider.checkIn != null && provider.checkOut == null) {
            navigatorKey.currentState?.push(
              MaterialPageRoute(
                builder: (context) => const CheckoutDetails(isAbsent: false),
              ),
            );
          } else {
            null;
            return;
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
      padding: const EdgeInsets.all(AppSizes.sm),
      child: Center(
        child: AutoSizeText(
          "Welcome, Arbin Shrestha ✌️",
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildToggleButton({
    required String text,
    required IconData icon,
    required WorkLocation location,
    required VoidCallback? onTap,
  }) {
    return Consumer<AttendanceProvider>(
      builder: (
        context,
        provider,
        child,
      ) {
        final selected = provider.location == location;
        return GestureDetector(
          onTap: provider.checkIn != null ? null : onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color:
                  selected ? context.colorScheme.primary : Colors.transparent,
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
                    color:
                        selected ? Colors.white : context.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
