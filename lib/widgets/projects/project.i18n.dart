import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //
  static var t = Translations("en_us") +
      {
        "en_us": "Loading...",
        "vi": "Đang tải...",
      } +
      {
        "en_us": "Add farm",
        "vi": "Thêm trang trại",
      } +
      {
        "en_us": "Add station",
        "vi": "Thêm trạm bơm",
      } +
      {
        "en_us": "No station found",
        "vi": "Không thấy trạm bơm nào",
      } +
      {
        "en_us": "Add device",
        "vi": "Thêm thiết bị",
      };

  String get i18n => localize(this, t);

  String fill(List<Object> params) => localizeFill(this, params);

  String plural(int value) => localizePlural(value, this, t);

  String version(Object modifier) => localizeVersion(modifier, this, t);

  Map<String?, String> allVersions() => localizeAllVersions(this, t);
}
