import 'package:hive/hive.dart';

class CacheService {
  static const int kCacheDuration = 20;
  static const String kUpdatedAtKey = 'updatedAt';
  static const String kCacheBoxName = 'cache_box';

  final Future<Box<String>> cacheBox = Hive.openBox(kCacheBoxName);

  Future<String> get(String key) async {
    final box = await cacheBox;
    String value = box.get(key);

    final DateTime lastUpdated = DateTime.tryParse(
          box.get(kUpdatedAtKey, defaultValue: ''),
        ) ??
        DateTime.now();

    if (DateTime.now().difference(lastUpdated) >
        const Duration(minutes: kCacheDuration)) {
      _delete(key);
      return null;
    }
    return value;
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
