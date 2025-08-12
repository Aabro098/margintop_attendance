// ignore_for_file: use_build_context_synchronously

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:margintop_attendance/common/reusables/back_button.dart';
import 'package:margintop_attendance/common/reusables/loading_indicator.dart';
import 'package:margintop_attendance/common/widgets/text_field.dart';
import 'package:margintop_attendance/services/user_services.dart';
import 'package:margintop_attendance/utils/constants/sizes.dart';

class PasswordChangeRequest extends StatefulWidget {
  const PasswordChangeRequest({
    super.key,
  });

  @override
  State<PasswordChangeRequest> createState() => _PasswordChangeRequestState();
}

class _PasswordChangeRequestState extends State<PasswordChangeRequest> {
  final GlobalKey<FormState> _requestFormKey = GlobalKey<FormState>();

  bool _isLoading = false;

  final TextEditingController _emailController = TextEditingController();

  Future<void> _handleRequest() async {
    if (!_requestFormKey.currentState!.validate()) {
      return;
    }
    try {
      FocusScope.of(context).unfocus();

      if (mounted) {
        setState(() {
          _isLoading = true;
        });
        final response = await UserServices().requestChange(
          email: _emailController.text.trim(),
        );
        if (response != null) {
          if (response['status'] == 1 && response['message'] == "Success") {
            // showSuccessSnackbar('request_change_successful', context: context);
            _emailController.clear();
          } else {
            // showErrorSnackbar(response['message'], context: context);
          }
        } else {
          // showErrorSnackbar('error_occured', context: context);
        }
      }
    } catch (e) {
      debugPrint(e.toString());
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
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(AppSizes.padding),
        child: SingleChildScrollView(
          child: Form(
            key: _requestFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBackButton(
                  theme: theme,
                ),
                const SizedBox(
                  height: 102,
                ),
                AutoSizeText(
                  "Forgot you password? Don't worry workmate you can request for a change here.",
                  style: theme.textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: AppSizes.xl,
                ),
                Semantics(
                  textField: true,
                  child: TextFieldData(
                    hintText: "Enter Email",
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email is required";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                _isLoading
                    ? const LoadingIndicator()
                    : ElevatedButton(
                        onPressed: () {
                          _isLoading ? null : _handleRequest();
                        },
                        child: const Text(
                          "Request Change",
                        ),
                      ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
