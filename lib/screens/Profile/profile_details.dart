import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:margintop_solutions/utils/constants/sizes.dart';

class ProfileDetails extends StatefulWidget {
  const ProfileDetails({
    super.key,
  });

  static Widget _rowDetails(
    ThemeData theme, {
    required String label,
    required String value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AutoSizeText(
          label,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        AutoSizeText(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(AppSizes.padding),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(
          AppSizes.md,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ProfileDetails._rowDetails(
            theme,
            label: 'DOB',
            value: '2002-10-26',
          ),
          const SizedBox(
            height: AppSizes.sm,
          ),
          ProfileDetails._rowDetails(
            theme,
            label: 'Phone',
            value: '9848096245',
          ),
        ],
      ),
    );
  }
}
