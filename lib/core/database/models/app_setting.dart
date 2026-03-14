import 'package:isar/isar.dart';

part 'app_setting.g.dart';

/// Key-value entry for local storage (replaces GetStorage-style usage).
@collection
class AppSetting {
  AppSetting();

  Id id = Isar.autoIncrement;

  late String key;

  late String value;
}
