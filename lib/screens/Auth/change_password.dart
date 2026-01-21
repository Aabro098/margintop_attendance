import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:margintop_solutions/common/reusables/custom_button.dart';
import 'package:margintop_solutions/common/widgets/text_field.dart';
import 'package:margintop_solutions/extensions/extensions.dart';
import 'package:margintop_solutions/services/dio_services.dart';
import 'package:margintop_solutions/utils/Validators/validators.dart';
import 'package:margintop_solutions/utils/constants/app_strings.dart';
import 'package:margintop_solutions/utils/constants/sizes.dart';
import 'package:margintop_solutions/utils/helpers/helper_functions.dart';
import 'package:margintop_solutions/utils/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController currentPasswordController =
      TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> _changeFormKey = GlobalKey<FormState>();

  Future<void> _handleChangePassword() async {
    if (!_changeFormKey.currentState!.validate()) return;
    try {
      await context.read<AuthProvider>().changePassword(
            currentPassword: currentPasswordController.text.trim(),
            newPassword: newPasswordController.text.trim(),
          );
      showSuccessSnackbar('Password changed successfully!');
    } on DioException catch (e) {
      final errorMessage = DioClient.parseDioError(e);
      showErrorSnackbar(errorMessage);
      return;
    } catch (e) {
      showErrorSnackbar(AppStrings.error);
      return;
    }
  }

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AutoSizeText("Change Password"),
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
                  style: context.textTheme.titleLarge,
                ),
                const SizedBox(height: AppSizes.lg),
                TextFieldData(
                  hintText: 'Current Password',
                  controller: currentPasswordController,
                  prefixIcon: Iconsax.lock,
                  validator: Validators.password,
                  isPassword: true,
                ),
                const SizedBox(height: AppSizes.formHeight),
                TextFieldData(
                  hintText: "New Password",
                  controller: newPasswordController,
                  validator: Validators.password,
                  prefixIcon: Iconsax.lock,
                  isPassword: true,
                ),
                const SizedBox(height: AppSizes.formHeight),
                TextFieldData(
                  hintText: "Confirm Password",
                  controller: confirmPasswordController,
                  prefixIcon: Iconsax.lock,
                  validator: (value) => Validators.confirmPassword(
                    newPasswordController.text.trim(),
                    value,
                  ),
                  isPassword: true,
                ),
                const SizedBox(height: AppSizes.xl),
                Consumer<AuthProvider>(builder: (context, authProvider, child) {
                  return CustomElevatedButton(
                    isLoading: authProvider.isLoading,
                    onPressed: () async => _handleChangePassword(),
                    label: "Change Password",
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
