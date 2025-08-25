// ignore_for_file: deprecated_member_use

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:margintop_attendance/utils/constants/colors_light.dart';
import 'package:margintop_attendance/utils/constants/sizes.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
              const SizedBox(height: AppSizes.sm),
              if (_selectedDay != null)
                AttendanceCard(
                  date: _selectedDay!,
                  color: Colors.orange,
                  attendanceData: attendanceData,
                ),
              const SizedBox(
                height: AppSizes.appBarHeight,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AttendanceCard extends StatefulWidget {
  final DateTime date;
  final Color color;
  final Map<String, dynamic> attendanceData;

  const AttendanceCard({
    super.key,
    required this.date,
    required this.color,
    required this.attendanceData,
  });

  @override
  State<AttendanceCard> createState() => _AttendanceCardState();
}

class _AttendanceCardState extends State<AttendanceCard> {
  final PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final key =
        "${widget.date.year}-${widget.date.month.toString().padLeft(2, '0')}-${widget.date.day.toString().padLeft(2, '0')}";
    final data = widget.attendanceData[key];

    if (data == null) {
      return const AutoSizeText(
        "No data for this date",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.red,
          fontSize: 16,
        ),
        maxLines: null,
        overflow: TextOverflow.visible,
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.sm),
        child: Column(
          children: [
            SizedBox(
              height: 120,
              child: PageView(
                controller: _controller,
                children: [
                  // Page 1: Attendance Details
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AutoSizeText(
                            DateFormat('EEE, MMM d, yyyy').format(widget.date),
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(AppSizes.md),
                            ),
                            padding: const EdgeInsets.all(AppSizes.sm),
                            child: const AutoSizeText("Home"),
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(vertical: AppSizes.xs),
                        child: Divider(
                          thickness: 2,
                          color: Colors.grey.shade300,
                        ),
                      ),
                      Wrap(
                        spacing: AppSizes.md,
                        runSpacing: AppSizes.md,
                        children: [
                          details(
                            theme,
                            label: "Check In",
                            value: "10:30 AM",
                            color: Colors.green,
                          ),
                          details(
                            theme,
                            label: "Check Out",
                            value: "7:30 PM",
                            color: Colors.red,
                          ),
                          details(
                            theme,
                            label: "Work Hour",
                            value: "8",
                            color: Colors.orange,
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Page 2: Description
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppSizes.md),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSizes.lg),
                    ),
                    child: AutoSizeText(
                      "This is the description of the day.",
                      style: theme.textTheme.titleSmall,
                    ),
                  ),
                ],
              ),
            ),
            SmoothPageIndicator(
              controller: _controller,
              count: 2, // Two pages: attendance details and description
              effect: WormEffect(
                dotHeight: 6,
                dotWidth: 6,
                activeDotColor: Colors.green,
                dotColor: Colors.grey.shade300,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget details(ThemeData theme,
      {required String label, required String value, required Color color}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AutoSizeText(
          value,
          style: theme.textTheme.titleLarge
              ?.copyWith(fontWeight: FontWeight.bold, color: color),
        ),
        AutoSizeText(
          label,
          style: theme.textTheme.titleSmall,
        ),
      ],
    );
  }
}
