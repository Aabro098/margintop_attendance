import 'package:flutter/material.dart';
import 'package:margintop_attendance/utils/constants/sizes.dart';

class CustomMonthDropdown extends StatefulWidget {
  final List<String> months;
  final String initialMonth;
  const CustomMonthDropdown({
    super.key,
    required this.months,
    required this.initialMonth,
  });

  @override
  State<CustomMonthDropdown> createState() => _CustomMonthDropdownState();
}

class _CustomMonthDropdownState extends State<CustomMonthDropdown> {
  late String selectedMonth;
  final GlobalKey _buttonKey = GlobalKey();
  double buttonWidth = 0;

  @override
  void initState() {
    super.initState();
    selectedMonth = widget.initialMonth;

    // Wait for first build to measure button
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final renderBox =
          _buttonKey.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        setState(() {
          buttonWidth = renderBox.size.width;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return PopupMenuButton<String>(
      position: PopupMenuPosition.under,

      // 👇 The button itself
      child: Container(
        key: _buttonKey, // key to measure width
        padding: const EdgeInsets.all(AppSizes.sm),
        decoration: BoxDecoration(
          border: Border.all(color: theme.colorScheme.secondary),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(selectedMonth),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),

      // 👇 The popup menu
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry<String>>[
          PopupMenuItem(
            enabled: false, // disables direct tap
            padding: EdgeInsets.zero,
            child: SizedBox(
              height: 200,
              width: buttonWidth > 0 ? buttonWidth : null, // match button width
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: widget.months.length,
                itemBuilder: (context, index) {
                  final month = widget.months[index];
                  return InkWell(
                    onTap: () {
                      if (mounted) {
                        setState(() {
                          selectedMonth = month;
                        });
                      }
                      Navigator.pop(context); // close the popup
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Center(
                        child: Text(
                          month,
                          style: theme.textTheme.titleSmall
                              ?.copyWith(fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ];
      },
    );
  }
}
