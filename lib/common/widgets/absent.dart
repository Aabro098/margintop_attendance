// ignore_for_file: use_build_context_synchronously

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:margintop_solutions/common/reusables/text_dialog.dart';
import 'package:margintop_solutions/services/attendance_services.dart';
import 'package:margintop_solutions/utils/constants/app_strings.dart';
import 'package:margintop_solutions/utils/helpers/helper_functions.dart';
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
  final TextEditingController _reasonController = TextEditingController();
  bool _isAbsent = false;
  Future<void> _absent() async {
    if (_reasonController.text.trim().isEmpty) {
      showErrorSnackbar("Your absent reason cannot be empty.");
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
              "We will miss you dear workmate. Hope to see you soon");
          _reasonController.clear();
        } else {
          showErrorSnackbar(response['message']);
        }
      } else {
        showErrorSnackbar(
          AppStrings.error,
        );
      }
    } catch (e) {
      showErrorSnackbar(AppStrings.error);
    } finally {
      if (mounted) {
        setState(() {
          _isAbsent = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Consumer<AttendanceProvider>(
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
                : Center(
                    child: SizedBox(
                      width: 172,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              16,
                            ),
                          ),
                        ),
                        onPressed: () async {
                          final dialog = StylishInputDialog(
                            context: context,
                            title: 'Please provide the reason for the leave.',
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
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
      },
    );
  }
}
