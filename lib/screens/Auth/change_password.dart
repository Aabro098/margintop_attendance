// ignore_for_file: use_build_context_synchronously

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:margintop_attendance/common/reusables/loading_indicator.dart';
import 'package:margintop_attendance/common/widgets/appbar_back_button.dart';
import 'package:margintop_attendance/common/widgets/text_field.dart';
import 'package:margintop_attendance/services/user_services.dart';
import 'package:margintop_attendance/utils/constants/sizes.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({
    super.key,
  });

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> _changeFormKey = GlobalKey<FormState>();

  bool _isLoading = false;

  Future<void> _handleChangePassword() async {
    if (_changeFormKey.currentState!.validate()) {
      try {
        if (mounted) {
          setState(() {
            _isLoading = true;
          });
        }
        final response = await UserServices().changePassword(
          currentPassword: _currentPasswordController.text.trim(),
          confirmPassword: _confirmPasswordController.text.trim(),
        );
        if (response != null) {
          if (response['status'] == 1 && response['message'] == "Success") {
            // showSuccessSnackbar('change_password_successful', context: context);
          } else {
            // showErrorSnackbar('could_not_change_password', context: context);
          }
        } else {
          // showErrorSnackbar('error_occured', context: context);
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
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AutoSizeText("Change Password"),
        leading: const AppbarBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.padding),
        child: SingleChildScrollView(
          child: Form(
            key: _changeFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  "You can change your password here dear workmates !",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: AppSizes.lg,
                ),
                TextFieldData(
                  hintText: 'Current Password',
                  controller: _currentPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter your current password";
                    }
                    return null;
                  },
                  isPassword: true,
                ),
                const SizedBox(height: AppSizes.formHeight),
                TextFieldData(
                  hintText: "New Password",
                  controller: _newPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "New password is required";
                    }
                    return null;
                  },
                  isPassword: true,
                ),
                const SizedBox(height: AppSizes.formHeight),
                TextFieldData(
                  hintText: "Confirm Password",
                  controller: _confirmPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Confirm Password is required";
                    } else if (value != _newPasswordController.text.trim()) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                  isPassword: true,
                ),
                const SizedBox(
                  height: AppSizes.xl,
                ),
                _isLoading
                    ? const LoadingIndicator()
                    : ElevatedButton(
                        onPressed: () {
                          _isLoading ? null : _handleChangePassword();
                        },
                        child: const Text("Change Password"),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
