import '../../../core/constants/url_constants.dart';

String getImageUrl(
  String path, {
  ImageQuality imageQuality = ImageQuality.w300,
}) {
  return '${UrlConstants.IMAGE_BASE_URL}/${imageQuality.name}/$path';
}

enum ImageQuality { w300, w500, original }
