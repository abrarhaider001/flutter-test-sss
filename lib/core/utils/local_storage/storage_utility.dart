import 'package:sss/core/database/isar_storage.dart';

/// Key-value storage backed by Isar (local DB). On web, operations no-op or return null.
/// Prefer using [IsarStorage] and [isarStorageProvider] directly with Riverpod.
class MyLocalStorage {
  MyLocalStorage._internal();

  static bool _initialized = false;

  factory MyLocalStorage.instance() {
    if (!_initialized) {
      throw StateError(
        'MyLocalStorage not initialized. Call MyLocalStorage.init() first.',
      );
    }
    return MyLocalStorage._internal();
  }

  static Future<void> init(String bucketName) async {
    await IsarStorage.init();
    _initialized = true;
  }

  IsarStorage? get _storage => IsarStorage.instance;

  Future<void> writeData<T>(String key, T value) async {
    final s = _storage;
    if (s == null) return;
    if (value is String) {
      await s.writeString(key, value);
    } else if (value is int) {
      await s.writeInt(key, value);
    } else if (value is bool) {
      await s.writeBool(key, value);
    } else {
      await s.writeString(key, value.toString());
    }
  }

  T? readData<T>(String key) {
    final s = _storage;
    if (s == null) return null;
    if (T == String) return s.readString(key) as T?;
    if (T == int) return s.readInt(key) as T?;
    if (T == bool) return s.readBool(key) as T?;
    return s.readString(key) as T?;
  }

  Future<void> removeData(String key) async {
    await _storage?.remove(key);
  }

  Future<void> clearAll() async {
    await _storage?.clearAll();
  }
}
