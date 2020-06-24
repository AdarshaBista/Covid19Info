import 'package:hive/hive.dart';

import 'package:data_connection_checker/data_connection_checker.dart';

class CacheService {
  static const int kCacheDuration = 20;
  static const String kUpdatedAtKey = 'updatedAt';
  static const String kCacheBoxName = 'cache_box';

  final Future<Box<String>> cacheBox = Hive.openBox(kCacheBoxName);

  Future<String> get(String key) async {
    final box = await cacheBox;
    String value = box.get(key);

    if (value == null) return null;
    if (await _shouldInvalidate()) {
      _delete(key);
      return null;
    }
    return value;
  }

  Future<bool> _shouldInvalidate() async {
    final box = await cacheBox;

    final bool isConnected = await DataConnectionChecker().hasConnection;
    final DateTime lastUpdated = DateTime.tryParse(box.get(
          kUpdatedAtKey,
          defaultValue: '',
        )) ??
        DateTime.now();

    return isConnected &&
        DateTime.now().difference(lastUpdated) > const Duration(minutes: kCacheDuration);
  }

  Future<void> insert(String key, String value) async {
    final box = await cacheBox;
    await box.put(kUpdatedAtKey, DateTime.now().toIso8601String());
    await box.put(key, value);
  }

  Future<void> _delete(String key) async {
    final box = await cacheBox;
    box.delete(key);
  }
}
