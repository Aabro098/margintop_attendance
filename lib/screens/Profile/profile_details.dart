import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:margintop_solutions/extensions/extensions.dart';
import 'package:margintop_solutions/utils/constants/sizes.dart';

class ProfileDetails extends StatefulWidget {
  const ProfileDetails({
    super.key,
  });

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  @override
  Widget build(BuildContext context) {
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
          rowDetails(
            label: 'DOB',
            value: 'To be updated',
          ),
          const SizedBox(
            height: AppSizes.sm,
          ),
          rowDetails(
            label: 'Phone',
            value: 'To be updated',
          ),
        ],
      ),
    );
  }

  Widget rowDetails({
    required String label,
    required String value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AutoSizeText(
          label,
          style: context.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w400,
          ),
        ),
        AutoSizeText(
          value,
          style: context.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
