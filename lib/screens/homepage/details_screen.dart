import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:margintop_solutions/common/reusables/loading_animation.dart';
import 'package:margintop_solutions/common/widgets/appbar_back_button.dart';
import 'package:margintop_solutions/common/widgets/attendance_card.dart';
import 'package:margintop_solutions/utils/constants/colors_light.dart';
import 'package:margintop_solutions/utils/constants/sizes.dart';
import 'package:margintop_solutions/utils/device/device_utility.dart';

class AttendanceDetails extends StatefulWidget {
  final DateTime date;
  final Map<String, Map<String, String>> attendanceData;
  const AttendanceDetails({
    super.key,
    required this.date,
    required this.attendanceData,
  });

  @override
  State<AttendanceDetails> createState() => _AttendanceDetailsState();
}

class _AttendanceDetailsState extends State<AttendanceDetails> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 9), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = DeviceUtility.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        title: const AutoSizeText("Attendance Details"),
        leading: const AppbarBackButton(),
      ),
      body: Container(
        width: double.infinity,
        color: isDarkMode
            ? Colors.transparent
            : AppColorsLight.secondaryOpacity.withAlpha(92),
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.padding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AttendanceCard(
                date: widget.date,
                attendanceData: widget.attendanceData,
              ),
              const SizedBox(height: AppSizes.md),
              _isLoading
                  ? const LoadingAnimation(
                      height: 120,
                      width: double.infinity,
                    )
                  : const Text(
                      "✅ Data Loaded!",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
