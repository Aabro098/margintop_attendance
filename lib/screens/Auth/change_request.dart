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
import 'package:margintop_solutions/utils/constants/image_strings.dart';
import 'package:margintop_solutions/utils/constants/sizes.dart';
import 'package:margintop_solutions/utils/helpers/helper_functions.dart';
import 'package:margintop_solutions/utils/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class PasswordChangeRequest extends StatefulWidget {
  const PasswordChangeRequest({
    super.key,
  });

  @override
  State<PasswordChangeRequest> createState() => _PasswordChangeRequestState();
}

class _PasswordChangeRequestState extends State<PasswordChangeRequest> {
  final GlobalKey<FormState> _requestFormKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  Future<void> handleRequest() async {
    if (!_requestFormKey.currentState!.validate()) {
      return;
    }
    try {
      await context.read<AuthProvider>().requestChangePassword(
            email: emailController.text.trim(),
          );
      showSuccessSnackbar(
          'Password change request sent! Please wait for further instructions.');
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
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(AppSizes.padding),
        child: Form(
          key: _requestFormKey,
          child: Column(
            children: [
              Image.asset(
                context.isDarkMode ? AppLogos.markDark : AppLogos.markWhite,
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width * 0.8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
                child: AutoSizeText(
                  "Forgot your password?\nDon't worry workmate you can request for a change.",
                  style: context.textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: AppSizes.xl,
              ),
              TextFieldData(
                hintText: "Enter Email",
                controller: emailController,
                validator: Validators.email,
                prefixIcon: Iconsax.sms,
              ),
              const SizedBox(height: AppSizes.xl),
              Consumer<AuthProvider>(builder: (context, authProvider, child) {
                return CustomElevatedButton(
                  isLoading: authProvider.isLoading,
                  onPressed: () async => await handleRequest(),
                  label: "Request Change",
                );
              }),
            ],
          ),
        ),
      )),
    );
  }
}
