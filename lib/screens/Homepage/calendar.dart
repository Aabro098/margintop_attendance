import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:margintop_solutions/extensions/extensions.dart';
import 'package:margintop_solutions/screens/Homepage/details_screen.dart';
import 'package:margintop_solutions/utils/constants/sizes.dart';
import 'package:margintop_solutions/utils/providers/index_provider.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class AppCalendar extends StatefulWidget {
  const AppCalendar({super.key});

  @override
  State<AppCalendar> createState() => _AppCalendarState();
}

class _AppCalendarState extends State<AppCalendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          context.read<IndexProvider>().setIndex(0);
        }
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.padding),
          child: SafeArea(
            child: Column(
              children: [
                AutoSizeText(
                  "Calendar",
                  overflow: TextOverflow.visible,
                  style: context.textTheme.headlineMedium?.copyWith(
                    color: context.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: AppSizes.sm),
                TableCalendar(
                  firstDay: DateTime.utc(2025, 1, 1),
                  lastDay: DateTime(
                      DateTime.now().year, DateTime.now().month + 1, 0),
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
      ),
    );
  }
}
