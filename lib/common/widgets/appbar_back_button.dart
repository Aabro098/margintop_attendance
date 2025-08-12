import 'package:flutter/material.dart';

class AppbarBackButton extends StatefulWidget {
  const AppbarBackButton({
    super.key,
  });

  @override
  State<AppbarBackButton> createState() => _AppbarBackButtonState();
}

class _AppbarBackButtonState extends State<AppbarBackButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 10.0, 0, 10.0),
      child: SizedBox(
        width: 72,
        height: 36,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            padding: const EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(8),
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            size: 24,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}
