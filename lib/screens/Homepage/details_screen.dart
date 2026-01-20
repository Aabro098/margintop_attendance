// ignore_for_file: use_build_context_synchronously

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:margintop_solutions/common/widgets/appbar_back_button.dart';
import 'package:margintop_solutions/common/widgets/attendance_card.dart';
import 'package:margintop_solutions/extensions/extensions.dart';
import 'package:margintop_solutions/services/attendance_services.dart';
import 'package:margintop_solutions/utils/constants/sizes.dart';
import 'package:margintop_solutions/utils/helpers/helper_functions.dart';

class AttendanceDetails extends StatefulWidget {
  final DateTime date;
  const AttendanceDetails({
    super.key,
    required this.date,
  });

  @override
  State<AttendanceDetails> createState() => _AttendanceDetailsState();
}

class _AttendanceDetailsState extends State<AttendanceDetails> {
  bool _isLoading = true;
  bool _isAbsent = false;
  int? year;
  int? month;
  int? day;

  String? checkIn;
  String? checkOut;
  String? workHour;
  String? status;
  String? workSummary;

  @override
  void initState() {
    super.initState();
    final dateTime = DateTime.parse(widget.date.toString());

    year = dateTime.year;
    month = dateTime.month;
    day = dateTime.day;

    setState(() {});

    _fetchSummary(year, month, day);
  }

  Future<void> _fetchSummary(int? year, int? month, int? day) async {
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }
    try {
      if (year != null && month != null && day != null) {
        final response = await AttendanceServices()
            .getSummaryDay(year: year, month: month, day: day);
        // if (response.status == 1 && response.message == "Success") {
        //   if (response.data.first.status == "remote" ||
        //       response.data.first.status == "present") {
        //     if (mounted) {
        //       setState(() {
        //         checkIn = response.data.first.checkInTime ?? '';
        //         checkOut = response.data.first.checkOutTime ?? '';
        //         status = response.data.first.status ?? '';
        //         workSummary = response.data.first.workSummary ?? '';
        //       });
        //     }
        //   } else if (response.data.first.status == "absent") {
        //     if (mounted) {
        //       setState(() {
        //         _isAbsent = true;
        //         status = response.data.first.status ?? '';
        //         workSummary = response.data.first.workSummary ?? '';
        //       });
        //     }
        //   }
        // } else {
        //   showErrorSnackbar("No attendance record found.", context: context);
        // }
      }
    } catch (e) {
      showErrorSnackbar("No attendance record found.");
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AutoSizeText("Attendance Details"),
        leading: const AppbarBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.padding),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              (checkIn != null && checkIn != '')
                  ? AttendanceCard(
                      date: widget.date,
                      checkIn: checkIn ?? '',
                      checkOut: checkOut ?? '',
                      workHour: workHour ?? '',
                      status: status ?? '',
                    )
                  : const SizedBox.shrink(),
              _isAbsent
                  ? AutoSizeText(
                      "Absent",
                      style: context.textTheme.titleMedium?.copyWith(
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    )
                  : const SizedBox.shrink(),
              const SizedBox(
                height: AppSizes.lg,
              ),
              Html(
                data: workSummary?.isNotEmpty == true
                    ? workSummary!
                    : "<p>No record found.</p>",
                style: {
                  "p": Style(
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                  ),
                  "body": Style(
                    padding: HtmlPaddings.zero,
                  ),
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
