// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:margintop_attendance/common/reusables/bottom_navbar.dart';
import 'package:margintop_attendance/common/reusables/loading_indicator.dart';
import 'package:margintop_attendance/common/widgets/text_field.dart';
import 'package:margintop_attendance/screens/Auth/change_request.dart';
import 'package:margintop_attendance/services/user_services.dart';
import 'package:margintop_attendance/utils/constants/colors_light.dart';
import 'package:margintop_attendance/utils/constants/image_strings.dart';
import 'package:margintop_attendance/utils/constants/sizes.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:margintop_attendance/utils/device/device_utility.dart';

//* The login screen uses the text field data which is a text form field in the common widgets
class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  Future<void> _handleLogin() async {
    if (!_loginFormKey.currentState!.validate()) return;

    FocusScope.of(context).unfocus();

    if (mounted) setState(() => _isLoading = true);

    try {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      final response = await UserServices().loginUser(
        email: email,
        password: password,
      );

      if (response != null) {
        if (response['message'] == "Success" && response['status'] == 1) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const BottomNavBar(),
            ),
            (route) => false,
          );
        } else {
          // showErrorSnackbar(response['message'], context: context);
        }
      } else {
        // showErrorSnackbar('error_occured', context: context);
      }
    } catch (e) {
      debugPrint("Login Error: $e");
      // showErrorSnackbar('error_occured', context: context);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(
            AppSizes.padding,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _loginFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  Center(
                    child: SizedBox(
                      height: DeviceUtility.getScreenHeight(context) * 0.3,
                      width: DeviceUtility.getScreenWidth(context) * 0.8,
                      child: FittedBox(
                        fit: BoxFit.contain,
                        child: SvgPicture.asset(
                          AppLogos.verticalLight,
                          color: AppColorsLight.logoColor,
                        ),
                      ),
                    ),
                  ),
                  AutoSizeText(
                    'This is MarginTop Solutions User App.',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: theme.colorScheme.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSizes.lg),
                  TextFieldData(
                    hintText: 'Enter email',
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Email is required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSizes.formHeight),
                  Semantics(
                    textField: true,
                    label: 'Enter Password',
                    child: TextFieldData(
                      hintText: 'Enter Password',
                      controller: _passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password is required";
                        }
                        return null;
                      },
                      isPassword: true,
                    ),
                  ),
                  const SizedBox(
                    height: AppSizes.xs,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PasswordChangeRequest(),
                          ),
                        );
                      },
                      child: const AutoSizeText(
                        'Forgot Password?',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: AppSizes.md,
                  ),
                  _isLoading
                      ? const LoadingIndicator()
                      : ElevatedButton(
                          onPressed: () {
                            _isLoading ? null : _handleLogin();
                          },
                          child: const Text('Login'),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
