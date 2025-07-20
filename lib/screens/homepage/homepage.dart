import 'package:flutter/material.dart';
import 'package:ordertracking_flutter/app.dart';
import 'package:ordertracking_flutter/common/widgets/custom_button.dart';
import 'package:ordertracking_flutter/utils/providers/localization_provider.dart';
import 'package:ordertracking_flutter/utils/providers/theme.provider.dart';
import 'package:ordertracking_flutter/common/widgets/app_bar_menu.dart';
import 'package:ordertracking_flutter/common/widgets/bottom_nav_bar.dart';
import 'package:ordertracking_flutter/common/widgets/custom_drawer.dart';
import 'package:ordertracking_flutter/utils/helpers/notification_service.dart';
import 'package:ordertracking_flutter/utils/helpers/toast_helper.dart';
import 'package:ordertracking_flutter/localization/app_localization.dart';
import 'package:ordertracking_flutter/utils/helpers/helper_functions.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.themeProvider});

  final ThemeProvider themeProvider;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizationProvider = Provider.of<LocalizationProvider>(context);

    return ScaffoldMessenger(
      key: scaffoldMessengerKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)?.translate('title') ?? ''),
          centerTitle: true,
          actions: [
            //* Right Menu
            AppBarMenu(
              themeProvider: widget.themeProvider,
              localizationProvider: localizationProvider,
            ),
          ],
        ),
        //* Left Menu
        drawer: const CustomDrawer(),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 34),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  text: AppLocalizations.of(context)
                          ?.translate('show_success_message') ??
                      'Show Success Message',
                  onPressed: () {
                    showSuccessSnackbar(
                        AppLocalizations.of(context)
                                ?.translate('operation_successful') ??
                            'Operation Successful',
                        time: 1000);
                    showToast(AppLocalizations.of(context)
                            ?.translate('operation_successful') ??
                        'Operation Successful');
                  },
                ),
                const SizedBox(height: 16),
                CustomButton(
                  text: AppLocalizations.of(context)
                          ?.translate('show_error_message') ??
                      'Show Error Message',
                  onPressed: () {
                    showErrorSnackbar(
                      AppLocalizations.of(context)
                              ?.translate('something_went_wrong') ??
                          'Something went wrong!',
                    );
                    showToast(AppLocalizations.of(context)
                            ?.translate('error_occurred') ??
                        'Error Occurred!');
                  },
                ),
                const SizedBox(height: 16),
                CustomButton(
                  text: AppLocalizations.of(context)
                          ?.translate('show_info_message') ??
                      'Show Info Message',
                  onPressed: () {
                    showInfoSnackbar(
                        AppLocalizations.of(context)
                                ?.translate('info_message') ??
                            'This is an info message.',
                        time: 1000);
                    showToast(AppLocalizations.of(context)
                            ?.translate('info_check_details') ??
                        'Info: Check details.');
                  },
                ),
                const SizedBox(height: 16),
                CustomButton(
                  text: AppLocalizations.of(context)
                          ?.translate('show_notifications') ??
                      'Show Notifications',
                  onPressed: () {
                    NotificationService().showNotification(
                      title: AppLocalizations.of(context)
                              ?.translate('example_notification') ??
                          'Example Notification',
                      body: AppLocalizations.of(context)
                              ?.translate('notification_body') ??
                          'Body of Example Notification',
                    );
                  },
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
      ),
    );
  }
}
