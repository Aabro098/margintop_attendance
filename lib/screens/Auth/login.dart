import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:margintop_solutions/common/reusables/bottom_navbar.dart';
import 'package:margintop_solutions/common/reusables/custom_button.dart';
import 'package:margintop_solutions/common/widgets/text_field.dart';
import 'package:margintop_solutions/extensions/extensions.dart';
import 'package:margintop_solutions/screens/Auth/change_request.dart';
import 'package:margintop_solutions/utils/Validators/validators.dart';
import 'package:margintop_solutions/utils/constants/app_strings.dart';
import 'package:margintop_solutions/utils/constants/image_strings.dart';
import 'package:margintop_solutions/utils/constants/sizes.dart';
import 'package:margintop_solutions/services/dio_services.dart';
import 'package:margintop_solutions/utils/helpers/app_globals.dart';
import 'package:margintop_solutions/utils/helpers/helper_functions.dart';
import 'package:margintop_solutions/utils/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  Future<void> _handleLogin() async {
    if (!_loginFormKey.currentState!.validate()) return;
    try {
      await context.read<AuthProvider>().login(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          );
      await navigatorKey.currentState?.pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const BottomNavBar(
            title: 'Home',
          ),
        ),
        (route) => false,
      );
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
    passwordController.dispose();
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: AppSizes.xl),
                  Image.asset(
                    context.isDarkMode ? AppLogos.markDark : AppLogos.markWhite,
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.8,
                  ),
                  AutoSizeText(
                    'Welcome',
                    style: context.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSizes.xs),
                  AutoSizeText(
                    'Enter your credentials to continue.',
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSizes.xl),
                  TextFieldData(
                    hintText: 'Enter Email',
                    controller: emailController,
                    validator: Validators.email,
                    prefixIcon: Iconsax.sms,
                  ),
                  const SizedBox(height: AppSizes.formHeight),
                  TextFieldData(
                    hintText: 'Enter Password',
                    controller: passwordController,
                    validator: Validators.password,
                    isPassword: true,
                    prefixIcon: Iconsax.lock,
                  ),
                  const SizedBox(height: AppSizes.md),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        navigatorKey.currentState?.push(
                          MaterialPageRoute(
                            builder: (context) => const PasswordChangeRequest(),
                          ),
                        );
                      },
                      child: AutoSizeText(
                        'Forgot Password?',
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colorScheme.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSizes.xl),
                  Consumer<AuthProvider>(
                    builder: (context, provider, child) {
                      return CustomElevatedButton(
                        label: 'Login',
                        isLoading: provider.isLoading,
                        onPressed: () async => await _handleLogin(),
                      );
                    },
                  ),
                  const SizedBox(height: AppSizes.lg),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: context.colorScheme.primary,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.sm,
                        ),
                        child: AutoSizeText(
                          'Or',
                          style: context.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: context.colorScheme.primary,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: context.colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.md),
                  GestureDetector(
                    onTap: () async {
                      await launchUrlString(
                          'https://margintopsolutions.com.np/');
                    },
                    child: AutoSizeText(
                      'Visit Our Website',
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSizes.xl * 2),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
