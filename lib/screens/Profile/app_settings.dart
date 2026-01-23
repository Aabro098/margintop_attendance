// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:margintop_solutions/extensions/extensions.dart';
import 'package:margintop_solutions/screens/Auth/change_password.dart';
import 'package:margintop_solutions/screens/Auth/login.dart';
import 'package:margintop_solutions/screens/Profile/setting_items.dart';
import 'package:margintop_solutions/utils/constants/colors_light.dart';
import 'package:margintop_solutions/utils/constants/image_strings.dart';
import 'package:margintop_solutions/utils/constants/sizes.dart';
import 'package:margintop_solutions/utils/device/device_utility.dart';
import 'package:margintop_solutions/utils/helpers/app_globals.dart';
import 'package:margintop_solutions/utils/providers/auth_provider.dart';
import 'package:margintop_solutions/utils/providers/theme.provider.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AppSettings extends StatefulWidget {
  const AppSettings({
    super.key,
  });
  @override
  State<AppSettings> createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
  File? imageFile;
  late Locale selectedLocale;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getUser();
    });
  }

  ImageProvider getProfileImage() {
    if (imageFile != null) {
      return FileImage(imageFile!);
      // } else if (provider.profileImage.isNotEmpty) {
      //   return NetworkImage(provider.profileImage);
    } else {
      return const AssetImage(AppLogos.nullProfile);
    }
  }

  Future<void> _getUser() async {
    try {
      await context.read<AuthProvider>().getUser();
    } on DioException {
      return;
    } catch (e) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.read<ThemeProvider>();
    final isDarkMode = DeviceUtility.isDarkMode(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.padding),
        child: SingleChildScrollView(
          child: Consumer<AuthProvider>(builder: (
            context,
            provider,
            child,
          ) {
            return Skeletonizer(
              enabled: provider.isLoading,
              enableSwitchAnimation: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AutoSizeText(
                    "Profile",
                    overflow: TextOverflow.visible,
                    style: context.textTheme.headlineMedium?.copyWith(
                      color: AppColorsLight.logoColor,
                    ),
                  ),
                  const SizedBox(
                    height: AppSizes.lg,
                  ),
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(AppSizes.xs),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColorsLight.logoColor,
                            width: 2,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 72,
                          backgroundColor: Colors.grey[200],
                          backgroundImage: getProfileImage(),
                        ),
                      ),
                      Positioned(
                        bottom: 12,
                        right: 6,
                        child: GestureDetector(
                          onTap: () async {
                            final pickedImage = await FilePicker.platform
                                .pickFiles(type: FileType.image);
                            if (pickedImage != null &&
                                pickedImage.files.isNotEmpty) {
                              final filePath = pickedImage.files.first.path;
                              if (filePath != null) {
                                setState(() {
                                  imageFile = File(filePath);
                                });
                              }
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(AppSizes.sm),
                            decoration: BoxDecoration(
                              color: AppColorsLight.logoColor,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: AppSizes.md,
                  ),
                  AutoSizeText(
                    provider.user?.name ?? "",
                    style: context.textTheme.headlineMedium?.copyWith(
                      color: context.colorScheme.primary,
                      fontSize: 24,
                    ),
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: AppSizes.xs,
                  ),

                  AutoSizeText(
                    provider.user?.email ?? "",
                    style: context.textTheme.titleLarge?.copyWith(
                      fontSize: 16,
                    ),
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSizes.md),
                  // Divider(
                  //   thickness: 1,
                  //   color: Colors.grey.shade300,
                  // ),
                  // const SizedBox(
                  //   height: AppSizes.xs,
                  // ),
                  // const ProfileDetails(),
                  // const SizedBox(
                  //   height: AppSizes.xs,
                  // ),
                  // Divider(
                  //   thickness: 1,
                  //   color: Colors.grey.shade300,
                  // ),
                  // const SizedBox(
                  //   height: AppSizes.xs,
                  // ),

                  const SizedBox(height: AppSizes.sm),
                  SettingItem(
                    icon: Iconsax.sun_14,
                    label: isDarkMode
                        ? "Change to Light Theme"
                        : "Change to Dark Theme",
                    onTap: () async {
                      await themeProvider.toggleTheme();
                    },
                  ),
                  SettingItem(
                    icon: Icons.change_circle_outlined,
                    label: "Change Password",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChangePassword(),
                        ),
                      );
                    },
                    showArrow: true,
                  ),
                  Skeletonizer(
                    enabled: provider.isLoggingOut,
                    enableSwitchAnimation: true,
                    child: SettingItem(
                      icon: Iconsax.logout,
                      label: "Logout",
                      onTap: () async {
                        await context.read<AuthProvider>().logout();
                        await navigatorKey.currentState?.pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      },
                      showArrow: true,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
