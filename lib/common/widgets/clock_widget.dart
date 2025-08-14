import 'dart:async';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class RealTimeClock extends StatefulWidget {
  const RealTimeClock({super.key});

  @override
  RealTimeClockState createState() => RealTimeClockState();
}

class RealTimeClockState extends State<RealTimeClock> {
  String _currentTime = '';
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _updateTime();
    // Update every second
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateTime();
    });
  }

  void _updateTime() {
    final now = DateTime.now();
    final formattedTime = _formatTime12Hour(now);
    if (mounted) {
      setState(() {
        _currentTime = formattedTime;
      });
    }
  }

  String _formatTime12Hour(DateTime dateTime) {
    // Convert to Nepal Time (NPT) - UTC+5:45
    DateTime nepaliTime =
        dateTime.toUtc().add(const Duration(hours: 5, minutes: 45));

    int hour = nepaliTime.hour;
    int minute = nepaliTime.minute;
    int second = nepaliTime.second;

    String period = hour >= 12 ? 'PM' : 'AM';

    // Convert to 12-hour format
    if (hour == 0) {
      hour = 12; // Midnight
    } else if (hour > 12) {
      hour = hour - 12;
    }

    // Format with leading zeros
    String hourStr = hour.toString().padLeft(2, '0');
    String minuteStr = minute.toString().padLeft(2, '0');
    String secondStr = second.toString().padLeft(2, '0');

    return '$hourStr : $minuteStr : $secondStr $period';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      _currentTime,
      style: Theme.of(context).textTheme.headlineMedium,
      maxLines: 1,
    );
  }
}
