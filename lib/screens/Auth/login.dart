// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:margintop_solutions/common/reusables/bottom_navbar.dart';
import 'package:margintop_solutions/common/reusables/loading_indicator.dart';
import 'package:margintop_solutions/common/widgets/text_field.dart';
import 'package:margintop_solutions/extensions/extensions.dart';
import 'package:margintop_solutions/screens/Auth/change_request.dart';
import 'package:margintop_solutions/services/user_services.dart';
import 'package:margintop_solutions/utils/constants/app_strings.dart';
import 'package:margintop_solutions/utils/constants/image_strings.dart';
import 'package:margintop_solutions/utils/constants/sizes.dart';
import 'package:margintop_solutions/utils/helpers/helper_functions.dart';
import 'package:margintop_solutions/utils/local_storage/user_prefs.dart';

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
          showSuccessSnackbar(response['message'], context: context);
          final token = response['data']['token'];
          final name = response['data']['user']['name'];
          final email = response['data']['user']['email'];

          await UserPrefs().saveUser(name, email, token);

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const BottomNavBar(
                title: 'Home',
              ),
            ),
            (route) => false,
          );
        } else {
          showErrorSnackbar("The provided crediential is wrong.",
              context: context);
        }
      } else {
        showErrorSnackbar(AppStrings.error, context: context);
      }
    } catch (e) {
      debugPrint("Login Error: $e");
      showErrorSnackbar('Error Occured : Server/Internet Issue',
          context: context);
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      context.isDarkMode
                          ? AppLogos.markDark
                          : AppLogos.markWhite,
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width * 0.8,
                    ),
                  ),
                  AutoSizeText(
                    'This is MarginTop Solutions User App.',
                    style: context.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: context.colorScheme.primary,
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
