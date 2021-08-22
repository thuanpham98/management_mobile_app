import 'package:i18n_extension/i18n_extension.dart';

// Developed by Marcelo Glasberg (Aug 2019).
// For more info, see: https://pub.dartlang.org/packages/i18n_extension

extension Localization on String {
  //
  static var t = Translations("en_us") +
      {
        "en_us": "General settings",
        "vi": "Cài đặt cơ bản",
      } +
      {
        "en_us": "Profile",
        "vi": "Hồ sơ",
      } +
      {
        "en_us": "Settings",
        "vi": "Cài đặt",
      } +
      {
        "en_us": "Dark Theme",
        "vi": "Giao diện tối",
      } +
      {
        "en_us": "Language",
        "vi": "Ngôn ngữ",
      }+
      {
        "en_us": "Others",
        "vi": "Khác",
      }+ 
      {
        "en_us": "Rate this App",
        "vi": "Đánh giá ứng dụng",
      }+
      {
        "en_us": "About Us",
        "vi": "Liên hệ với chúng tôi",
      }+
      {
        "en_us": "Logout",
        "vi": "Thoát",
      }+
      {
        "en_us": "Tracking",
        "vi": "Cho phép nhận thông báo",
      }+
      {
        "en_us": "Change language successfully",
        "vi": "Thay đổi ngôn ngữ thành công",
      };

  String get i18n => localize(this, t);

  String fill(List<Object> params) => localizeFill(this, params);

  String plural(int value) => localizePlural(value, this, t);

  String version(Object modifier) => localizeVersion(modifier, this, t);

  Map<String?, String> allVersions() => localizeAllVersions(this, t);
}
