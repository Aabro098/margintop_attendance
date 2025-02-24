import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
// TODO: Add Support for maxOS and Linux Systems.
// TODO: Create Various other functions for different type of notifications.
  // _showNotificationWithActions()
  // _showNotificationWithTextAction()
  // _showNotificationWithIconAction()
  // _showNotificationWithTextChoice()
  // _showNotificationWithNoBody()
  // _showNotificationWithNoTitle()
  // _cancelNotification()
  // _showNotificationCustomSound()
  // _zonedScheduleNotification()
  // _showNotificationWithNoSound()
  // _showNotificationSilently()
  // https://pub.dev/packages/flutter_local_notifications/example

  //* Variables
  final notificationsPlugin = FlutterLocalNotificationsPlugin();
  final bool _isInit = false;

  //* Getters
  bool get isInit {
    return _isInit;
  }

  //! Initialization
  Future<void> initiNotification() async {
    if (_isInit) return; // already initialized

    // ANDROID INITIALIZATION
    const androidInitSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS INITIALIZATION
    const iosInitSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    // LINUX INITIALIZATION
    const linuxInitializationSettings =
        LinuxInitializationSettings(defaultActionName: 'Open notification');

    // COMMON INITIALIZATION
    const initSettings = InitializationSettings(
      android: androidInitSettings,
      iOS: iosInitSettings,
      macOS: iosInitSettings,
      linux: linuxInitializationSettings,
    );

    // PLUGIN INITIALIZATION
    await notificationsPlugin.initialize(initSettings);
  }

  //! Notification Detail Setup
  NotificationDetails notificationDetails() => const NotificationDetails(
      android: AndroidNotificationDetails(
        'example1',
        'example1 Notification',
        channelDescription: 'Example 1 Channel',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails());

  //! Show Notification Section:
  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
  }) async {
    return notificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails(),
    );
  }
}
