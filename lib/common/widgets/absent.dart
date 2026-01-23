import 'package:flutter/material.dart';
import 'package:margintop_solutions/common/reusables/custom_button.dart';
import 'package:margintop_solutions/extensions/extensions.dart';
import 'package:margintop_solutions/screens/Homepage/checkout_details.dart';
import 'package:margintop_solutions/utils/constants/sizes.dart';
import 'package:margintop_solutions/utils/helpers/app_globals.dart';
import 'package:margintop_solutions/utils/providers/attendance_provider.dart';
import 'package:provider/provider.dart';

class AbsentButton extends StatefulWidget {
  const AbsentButton({
    super.key,
  });

  @override
  State<AbsentButton> createState() => _AbsentButtonState();
}

class _AbsentButtonState extends State<AbsentButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.padding),
      child: Consumer<AttendanceProvider>(
        builder: (context, provider, child) {
          return (provider.checkIn == null || provider.isAbsent == false)
              ? Center(
                  child: SizedBox(
                    width: 232,
                    child: CustomElevatedButton(
                      color: context.colorScheme.error,
                      isLoading: false,
                      onPressed: () async {
                        await navigatorKey.currentState?.push(
                          MaterialPageRoute(
                            builder: (context) => const CheckoutDetails(
                              isAbsent: true,
                            ),
                          ),
                        );
                      },
                      label: "Absent",
                    ),
                  ),
                )
              : const SizedBox.shrink();
        },
      ),
    );
  }
}
