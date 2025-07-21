import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_mts/common/widgets/bottom_nav_bar.dart';
import 'package:flutter_boilerplate_mts/common/widgets/custom_button.dart';
import 'package:flutter_boilerplate_mts/common/widgets/custom_drawer.dart';
import 'package:flutter_boilerplate_mts/extensions/context_extensions.dart';
import 'package:flutter_boilerplate_mts/utils/helpers/helper_functions.dart';
import 'package:flutter_boilerplate_mts/utils/helpers/notification_service.dart';
import 'package:flutter_boilerplate_mts/utils/helpers/toast_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

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
    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr('title')),
        centerTitle: true,
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
                text: ('show_success_message'),
                onPressed: () {
                  showSuccessSnackbar(('operation_successful'), time: 1000);
                  showToast(('operation_successful'));
                },
              ),
              const SizedBox(height: 16),
              CustomButton(
                text: ('show_error_message'),
                onPressed: () {
                  showErrorSnackbar(('something_went_wrong'));
                  showToast(('error_occurred'));
                },
              ),
              const SizedBox(height: 16),
              CustomButton(
                text: ('show_info_message'),
                onPressed: () {
                  showInfoSnackbar(('info_message'), time: 1000);
                  showToast(('info_check_details'));
                },
              ),
              const SizedBox(height: 16),
              CustomButton(
                text: ('show_notifications'),
                onPressed: () {
                  NotificationService().showNotification(
                    title: ('example_notification'),
                    body: ('notification_body'),
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
    );
  }
}
