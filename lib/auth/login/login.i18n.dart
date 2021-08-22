import 'package:i18n_extension/i18n_extension.dart';

// Developed by Marcelo Glasberg (Aug 2019).
// For more info, see: https://pub.dartlang.org/packages/i18n_extension

extension Localization on String {
  //
  static var t = Translations("en_us") +
      {
        "en_us": "Go to next screen",
        "vi": "Di den trang ke tiep",
      }+
      {
        "en_us": "Precious Agricultural System",
        "vi": "Hệ thống nông nghiệp chính xác",
      }+
      {
        "en_us": "Free app service for PAS",
        "vi": "Ứng dụng miễn phí đi kèm hệ thống PAS",
      }+
      {
        "en_us": "Sign in with Google",
        "vi": "Đăng nhập",
      };

  String get i18n => localize(this, t);

  String fill(List<Object> params) => localizeFill(this, params);

  String plural(int value) => localizePlural(value, this, t);

  String version(Object modifier) => localizeVersion(modifier, this, t);

  Map<String?, String> allVersions() => localizeAllVersions(this, t);
}
