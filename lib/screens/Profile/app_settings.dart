// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:margintop_attendance/common/reusables/loading_indicator.dart';
import 'package:margintop_attendance/screens/Auth/change_password.dart';
import 'package:margintop_attendance/screens/Auth/login.dart';
import 'package:margintop_attendance/screens/Profile/setting_items.dart';
import 'package:margintop_attendance/services/user_services.dart';
import 'package:margintop_attendance/utils/constants/image_strings.dart';
import 'package:margintop_attendance/utils/constants/sizes.dart';
import 'package:margintop_attendance/utils/device/device_utility.dart';
import 'package:margintop_attendance/utils/local_storage/localization_storage.dart';
import 'package:margintop_attendance/utils/providers/theme.provider.dart';
import 'package:provider/provider.dart';

//* This file is part of the Nayan Saathi User App for managing the app settings like the language and the theme data
class AppSettings extends StatefulWidget {
  const AppSettings({
    super.key,
  });
  @override
  State<AppSettings> createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
  File? imageFile;
  bool _isLoading = false;
  bool _isNameLoading = false;
  late Locale selectedLocale;

  String name = 'Arbin Shrestha';
  String email = 'arbinstha71@gmail.com';

  @override
  void initState() {
    super.initState();
    // _getUserDetails();
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

  // Future<void> _getUserDetails() async {
  //   if (mounted) {
  //     setState(() {
  //       _isNameLoading = true;
  //     });
  //   }
  //   try {
  //     final response = await UserServices().userDetails();
  //     if (response != null) {
  //       if (response['message'] == "Success" && response['status'] == 1) {
  //         if (mounted) {
  //           setState(() {
  //             name = response['data']['name'];
  //             email = response['data']['email'];
  //           });
  //         }
  //       }
  //     } else {
  //       // showErrorSnackbar('error_occured', context: context);
  //     }
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   } finally {
  //     if (mounted) {
  //       setState(() {
  //         _isNameLoading = false;
  //       });
  //     }
  //   }
  // }

  //* This is to logout the user and remove the auth token from the shared prefs
  Future<void> _logout() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }
    try {
      final response = await UserServices().logout();
      if (response != null) {
        if (response['message'] == "Success" && response['status'] == 1) {
          await clearSharedPreferences();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
            (Route<dynamic> route) => false,
          );
        } else {
          // showErrorSnackbar(response['message'], context: context);
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

  // label: context.tr('settings_screen_feature'),
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final isDarkMode = DeviceUtility.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        title: const AutoSizeText(
          "Profile",
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSizes.padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: AppSizes.xl,
                  ),
                  // Profile Row
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 160,
                        height: 160,
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.indigo,
                            width: 2,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 80,
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
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.indigo[400],
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
                  _isNameLoading
                      ? const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: LoadingIndicator(),
                        )
                      : AutoSizeText(
                          name,
                          style: theme.textTheme.headlineMedium?.copyWith(
                            color: theme.colorScheme.primary,
                            fontSize: 24,
                          ),
                          softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                  _isNameLoading
                      ? const SizedBox.shrink()
                      : const SizedBox(height: AppSizes.sm),
                  _isNameLoading
                      ? const SizedBox.shrink()
                      : AutoSizeText(
                          email,
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontSize: 16,
                                  ),
                          softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                  const SizedBox(height: AppSizes.sm),
                  Divider(
                    thickness: 1,
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(height: AppSizes.sm),
                  AutoSizeText(
                    "Settings",
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: theme.colorScheme.primary,
                      fontSize: 20,
                    ),
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSizes.sm),
                  SettingItem(
                    icon: Iconsax.sun_14,
                    label: isDarkMode
                        ? "Change to Light Theme"
                        : "Change to Dark Theme",
                    onTap: () {
                      isDarkMode
                          ? themeProvider.setTheme(ThemeMode.light)
                          : themeProvider.setTheme(ThemeMode.dark);
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
                  _isLoading
                      ? const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: LoadingIndicator(),
                        )
                      : SettingItem(
                          icon: Iconsax.logout,
                          label: "Logout",
                          onTap: () {
                            _isLoading ? null : _logout();
                          },
                          showArrow: true,
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
