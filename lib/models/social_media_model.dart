import 'package:margintop_solutions/utils/constants/image_strings.dart';

class SocialMediaModel {
  final String path;
  final String url;

  SocialMediaModel({
    required this.path,
    required this.url,
  });
}

final List<SocialMediaModel> socialMediaList = [
  SocialMediaModel(
    path: AppLogos.linkedIn,
    url: 'https://www.margintop.com/',
  ),
  SocialMediaModel(
    path: AppLogos.facebook,
    url: 'https://www.margintop.com/',
  ),
  SocialMediaModel(
    path: AppLogos.instagram,
    url: 'https://www.margintop.com/',
  ),
  SocialMediaModel(
    path: AppLogos.website,
    url: 'https://www.margintop.com/',
  ),
  SocialMediaModel(
    path: AppLogos.maps,
    url: 'https://www.margintop.com/',
  ),
];
