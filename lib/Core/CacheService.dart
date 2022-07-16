// import 'package:hive/hive.dart';

import 'package:hive/hive.dart';

class CacheService {
  static Type typeOf<T>() => T;

  static Future<List<T>> getAll<T>() async {
    try {
      final type = typeOf<T>();
      final box = await Hive.openBox<T>('$type');
      final map = box.toMap();
      final lst = List<T>();
      map.forEach((_, value) {
        lst.add(value);
      });
      return lst;
    } catch (e) {}
    return null;
  }

  static Future<void> add<T>(dynamic key, T data) async {
    if (data == null) {
      return;
    }

    final type = typeOf<T>();
    final box = await Hive.openBox<T>('$type');

    await box.put(key, data);
  }

  static Future<T> getByKey<T>(dynamic key) async {
    try {
      final type = typeOf<T>();
      final box = await Hive.openBox<T>('$type');
      return box.get(key);
    } catch (e) {}
    return null;
  }

  static Future<void> clear<T>() async {
    final type = typeOf<T>();
    final box = await Hive.openBox<T>('$type');
    await box.clear();
  }

  static Future<void> delete<T>(dynamic key) async {
    final type = typeOf<T>();
    final box = await Hive.openBox<T>('$type');
    await box.deleteAll([key]);
  }
}
