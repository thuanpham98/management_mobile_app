import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //
  static var t = Translations("en_us") +
      {
        "en_us": "Location",
        "vi": "Cơ sở",
      } +
      {
        "en_us": "Station",
        "vi": "Khu trạm",
      } +
      {
        "en_us": "Automation",
        "vi": "Tự động hoá",
      } +
      {
        "en_us": "Notification",
        "vi": "Thông báo",
      } +
      {
        "en_us": "Monitoring",
        "vi": "Quan trắc",
      } +
      {
        "en_us": "Profile",
        "vi": "Cá nhân",
      };

  String get i18n => localize(this, t);

  String fill(List<Object> params) => localizeFill(this, params);

  String plural(int value) => localizePlural(value, this, t);

  String version(Object modifier) => localizeVersion(modifier, this, t);

  Map<String?, String> allVersions() => localizeAllVersions(this, t);
}
