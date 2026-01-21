class UrlStrings {
  UrlStrings._();

  static const String baseUrl = 'https://api.margintopsolutions.com.np/api/v1';

  static const String login = '/user/login';
  static const String logout = '/user/logout';
  static const String changePassword = '/user/update-password';
  static const String requestChange = '/user/forgot-password';

  static const String checkIn = '/user/attendance/check-in';
  static const String checkOut = '/user/attendance/check-out';
  static const String absent = '/user/attendance/absent';
  static const String getStatus = '/user/attendance/status';
  static const String stats = '/user/attendance/stats';
}
