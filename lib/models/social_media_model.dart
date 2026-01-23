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
    url: 'https://www.linkedin.com/company/margintop-solutions',
  ),
  SocialMediaModel(
    path: AppLogos.facebook,
    url: 'https://www.facebook.com/margintopsolutionsnepal',
  ),
  SocialMediaModel(
    path: AppLogos.instagram,
    url: 'https://www.instagram.com/margintopsolutions?igsh=ejlmeDZ4NzJpYnYw',
  ),
  SocialMediaModel(
    path: AppLogos.website,
    url: 'https://margintopsolutions.com/',
  ),
  SocialMediaModel(
    path: AppLogos.maps,
    url: 'https://maps.app.goo.gl/7MXGXeG3gaPt9bfv8?g_st=aw',
  ),
];
