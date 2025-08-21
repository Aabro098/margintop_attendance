// ignore_for_file: deprecated_member_use

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:margintop_attendance/utils/constants/colors_light.dart';
import 'package:margintop_attendance/utils/constants/sizes.dart';
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
    "2025-04-01": {
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
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.padding),
        child: Column(
          children: [
            const SizedBox(height: AppSizes.xl),
            AutoSizeText(
              "Calendar",
              overflow: TextOverflow.visible,
              style: theme.textTheme.headlineMedium?.copyWith(
                color: AppColorsLight.logoColor,
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
            // const SizedBox(height: 16),
            // if (_selectedDay != null)
            //   Card(
            //     shadowColor: Colors.grey.shade300,
            //     elevation: 2,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(12),
            //     ),
            //     child: Padding(
            //       padding: const EdgeInsets.all(AppSizes.sm),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceAround,
            //         children: [
            //           _buildAttendanceCard(
            //             date: _selectedDay!,
            //             title: 'Check In',
            //             time: '8:30 AM',
            //             color: Colors.green,
            //           ),
            //           _buildAttendanceCard(
            //             date: _selectedDay!,
            //             title: 'Check Out',
            //             time: '7:30 PM',
            //             color: Colors.red,
            //           ),
            //           _buildAttendanceCard(
            //             date: _selectedDay!,
            //             title: 'Work Hours',
            //             time: '8:30 AM',
            //             color: Colors.orange,
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendanceCard({
    required DateTime date,
    required String title,
    required String time,
    required Color color,
  }) {
    final key =
        "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
    final data = attendanceData[key];

    if (data == null) {
      return const Text("No data for this date");
    }
    return Container(
      width: 90,
      padding: const EdgeInsets.all(AppSizes.md),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(AppSizes.sm),
      ),
      child: Column(
        children: [
          AutoSizeText(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: AppSizes.sm),
          AutoSizeText(
            time,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
