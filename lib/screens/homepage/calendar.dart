// ignore_for_file: deprecated_member_use

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:margintop_solutions/screens/Homepage/details_screen.dart';
import 'package:margintop_solutions/utils/constants/sizes.dart';
import 'package:table_calendar/table_calendar.dart';

class AppCalendar extends StatefulWidget {
  const AppCalendar({super.key});

  @override
  State<AppCalendar> createState() => _AppCalendarState();
}

class _AppCalendarState extends State<AppCalendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // Dummy data for illustration
  Map<String, Map<String, String>> attendanceData = {
    "2025-08-01": {
      "checkIn": "10:00 AM",
      "checkOut": "06:30 PM",
      "workingHours": "08:30"
    },
    "2025-04-02": {
      "checkIn": "10:30 AM",
      "checkOut": "06:30 PM",
      "workingHours": "08:00"
    },
    "2025-04-03": {
      "checkIn": "10:30 AM",
      "checkOut": "06:00 PM",
      "workingHours": "07:30"
    },
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.padding),
          child: Column(
            children: [
              const SizedBox(height: AppSizes.xl),
              AutoSizeText(
                "Calendar",
                overflow: TextOverflow.visible,
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: AppSizes.sm),
              TableCalendar(
                firstDay: DateTime.utc(2025, 1, 1),
                lastDay:
                    DateTime(DateTime.now().year, DateTime.now().month + 1, 0),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: (selectedDay, focusedDay) {
                  if (mounted) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AttendanceDetails(
                        date: selectedDay,
                        attendanceData: attendanceData,
                      ),
                    ),
                  );
                },
                calendarStyle: const CalendarStyle(
                  isTodayHighlighted: true,
                  weekendTextStyle: TextStyle(
                    color: Colors.red,
                  ),
                  outsideDaysVisible: false,
                ),
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
