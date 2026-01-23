import 'package:flutter/material.dart';
import 'package:margintop_solutions/extensions/extensions.dart';
import 'package:margintop_solutions/models/social_media_model.dart';
import 'package:margintop_solutions/utils/constants/sizes.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SocialMedia extends StatelessWidget {
  const SocialMedia({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSizes.formHeight,
      children: socialMediaList
          .map(
            (socialMedia) => GestureDetector(
              onTap: () async {
                await launchUrlString(socialMedia.url);
              },
              child: Container(
                padding: const EdgeInsets.all(AppSizes.sm),
                decoration: BoxDecoration(
                  color: context.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(AppSizes.sm),
                  border: Border.all(
                    color: context.colorScheme.primary.withAlpha(102),
                  ),
                ),
                child: SvgPicture.asset(
                  socialMedia.path,
                  width: 32,
                  height: 28,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
