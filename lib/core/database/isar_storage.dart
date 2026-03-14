import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sss/core/database/models/app_setting.dart';

/// Local database storage using Isar. Not supported on web.
class IsarStorage {
  IsarStorage._();

  static Isar? _isar;
  static bool _initialized = false;

  static IsarStorage? get instance => _initialized ? IsarStorage._() : null;

  static Isar get _db {
    final db = _isar;
    if (db == null || !db.isOpen) {
      throw StateError('IsarStorage not initialized. Call IsarStorage.init() first (and only on non-web).');
    }
    return db;
  }

  /// Call once at app startup. No-op on web.
  static Future<void> init() async {
    if (kIsWeb) return;
    if (_initialized) return;

    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [AppSettingSchema],
      directory: dir.path,
    );
    _initialized = true;
  }

  Future<void> writeString(String key, String value) async {
    final existing = await _db.appSettings.filter().keyEqualTo(key).findFirst();
    final entity = AppSetting()
      ..key = key
      ..value = value;
    if (existing != null) {
      entity.id = existing.id;
    }
    await _db.writeTxn(() async {
      await _db.appSettings.put(entity);
    });
  }

  Future<void> writeInt(String key, int value) async =>
      writeString(key, value.toString());

  Future<void> writeBool(String key, bool value) async =>
      writeString(key, value.toString());

  String? readString(String key) {
    return _db.appSettings.filter().keyEqualTo(key).findFirstSync()?.value;
  }

  int? readInt(String key) {
    final s = readString(key);
    if (s == null) return null;
    return int.tryParse(s);
  }

  bool? readBool(String key) {
    final s = readString(key);
    if (s == null) return null;
    return s == 'true';
  }

  Future<void> remove(String key) async {
    await _db.writeTxn(() async {
      await _db.appSettings.filter().keyEqualTo(key).deleteAll();
    });
  }

  Future<void> clearAll() async {
    await _db.writeTxn(() async {
      await _db.appSettings.clear();
    });
  }
}
