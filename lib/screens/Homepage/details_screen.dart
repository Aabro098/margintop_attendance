// ignore_for_file: use_build_context_synchronously

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:margintop_solutions/common/widgets/attendance_card.dart';
import 'package:margintop_solutions/utils/constants/sizes.dart';
import 'package:margintop_solutions/utils/providers/attendance_provider.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
  String? checkIn;
  String? checkOut;
  String? workHour;
  String? status;
  String? workSummary;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchSummary();
    });
  }

  Future<void> fetchSummary() async {
    try {
      final attendance =
          await context.read<AttendanceProvider>().fetchSummaryDay(widget.date);

      if (mounted) {
        setState(() {
          checkIn = attendance['checkIn'];
          checkOut = attendance['checkOut'];
          workHour = attendance['workHour'];
          status = attendance['status'];
          workSummary = attendance['workSummary'];
        });
      }
    } on DioException {
      return;
    } catch (e) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = context.watch<AttendanceProvider>().isLoading;
    return Scaffold(
      appBar: AppBar(
        title: const AutoSizeText("Attendance Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.padding),
        child: SingleChildScrollView(
          child: Skeletonizer(
            enabled: isLoading,
            enableSwitchAnimation: true,
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
      ),
    );
  }
}
