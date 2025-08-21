import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:margintop_attendance/utils/constants/sizes.dart';

class AppBackButton extends StatefulWidget {
  const AppBackButton({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  State<AppBackButton> createState() => _AppBackButtonState();
}

class _AppBackButtonState extends State<AppBackButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 108,
      height: 42,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Center(
              child: Icon(
                Icons.arrow_back,
                size: AppSizes.iconMd,
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            AutoSizeText(
              'Back',
              style: widget.theme.textTheme.titleMedium?.copyWith(
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
