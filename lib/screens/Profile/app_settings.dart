// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:iconsax/iconsax.dart';
import 'package:margintop_solutions/common/reusables/app_drawer_wrapper.dart';
import 'package:margintop_solutions/common/reusables/bottom_navbar.dart';
import 'package:margintop_solutions/common/reusables/loading_animation.dart';
import 'package:margintop_solutions/common/reusables/menu_icon.dart';
import 'package:margintop_solutions/common/widgets/animation_slide.dart';
import 'package:margintop_solutions/common/widgets/custom_drawer.dart';
import 'package:margintop_solutions/screens/Auth/change_password.dart';
import 'package:margintop_solutions/screens/Auth/login.dart';
import 'package:margintop_solutions/screens/Profile/profile_details.dart';
import 'package:margintop_solutions/screens/Profile/setting_items.dart';
import 'package:margintop_solutions/services/user_services.dart';
import 'package:margintop_solutions/utils/constants/app_strings.dart';
import 'package:margintop_solutions/utils/constants/colors_light.dart';
import 'package:margintop_solutions/utils/constants/image_strings.dart';
import 'package:margintop_solutions/utils/constants/sizes.dart';
import 'package:margintop_solutions/utils/device/device_utility.dart';
import 'package:margintop_solutions/utils/helpers/helper_functions.dart';
import 'package:margintop_solutions/utils/local_storage/localization_storage.dart';
import 'package:margintop_solutions/utils/providers/attendance_provider.dart';
import 'package:margintop_solutions/utils/providers/drawer_provider.dart';
import 'package:margintop_solutions/utils/providers/theme.provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  late Locale selectedLocale;

  String? name;
  String? email;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeName();
    });
  }

  final _advancedDrawerController = AdvancedDrawerController();

  ImageProvider getProfileImage() {
    if (imageFile != null) {
      return FileImage(imageFile!);
      // } else if (provider.profileImage.isNotEmpty) {
      //   return NetworkImage(provider.profileImage);
    } else {
      return const AssetImage(AppLogos.nullProfile);
    }
  }

  Future<void> _initializeName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final storedName = prefs.getString('name') ?? '...';
    final storedEmail = prefs.getString('email') ?? '...';
    if (mounted) {
      setState(() {
        name = storedName;
        email = storedEmail;
      });
    }
  }

  //* This is to logout the user and remove the auth token from the shared prefs
  Future<void> _logout() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }
    try {
      final provider = context.read<AttendanceProvider>();
      final drawerProvider = context.read<DrawerProvider>();
      await UserServices().logout();
      await clearSharedPreferences();
      await provider.clearStatus();
      drawerProvider.setSelectedItem('Attendance');
      showSuccessSnackbar("Logout Successfull !!!", context: context);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      debugPrint(e.toString());
      showErrorSnackbar(AppStrings.error, context: context);
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
    _advancedDrawerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final isDarkMode = DeviceUtility.isDarkMode(context);
    return PopScope(
      canPop: false, // block system back entirely
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Navigator.pushReplacement(
            context,
            SlidePageRoute(
              page: const BottomNavBar(
                title: 'Home',
              ),
            ),
          );
          context.read<DrawerProvider>().setSelectedItem('Attendance');
        }
      },
      child: AppDrawerWrapper(
        drawer: const CustomDrawer(),
        controller: _advancedDrawerController,
        child: Scaffold(
          body: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(AppSizes.padding),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: AppSizes.xl,
                      ),
                      AutoSizeText(
                        "Profile",
                        overflow: TextOverflow.visible,
                        style: theme.textTheme.headlineMedium?.copyWith(
                          color: AppColorsLight.logoColor,
                        ),
                      ),
                      const SizedBox(
                        height: AppSizes.lg,
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
                                color: AppColorsLight.logoColor,
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
                                padding: const EdgeInsets.all(AppSizes.sm),
                                decoration: BoxDecoration(
                                  color: AppColorsLight.logoColor,
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: Colors.white, width: 2),
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
                        name ?? "...",
                        style: theme.textTheme.headlineMedium?.copyWith(
                          color: theme.colorScheme.primary,
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
                        email ?? "...",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
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
                      const SizedBox(
                        height: AppSizes.xs,
                      ),
                      const ProfileDetails(),
                      const SizedBox(
                        height: AppSizes.xs,
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.grey.shade300,
                      ),
                      const SizedBox(
                        height: AppSizes.xs,
                      ),
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
                          ? const LoadingAnimation(
                              height: 100,
                              width: double.infinity,
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
              ),
              MenuIcon(
                drawerController: _advancedDrawerController,
              )
            ],
          ),
        ),
      ),
    );
  }
}
