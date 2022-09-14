import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CacheService {
  static Type typeOf<T>() => T;

  static Future<List<T>> getAll<T>() async {
    try {
      final box = await Hive.openBox<T>('$T');
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

    final box = await Hive.openBox<T>('$T');
    await box.put(key, data);
  }

  static Future<void> edit<T>(int keyIndex, T data) async {
    if (data == null) {
      return;
    }
    final box = await Hive.openBox<T>('$T');
    await box.putAt(keyIndex, data);
  }

  static Future<T> getByKey<T>(dynamic key) async {
    try {
      final box = await Hive.openBox<T>('$T');
      return box.get(key);
    } catch (e) {}
    return null;
  }

  static Future<void> clear<T>() async {
    final box = await Hive.openBox<T>('$T');
    await box.clear();
  }

  static Future<void> delete<T>(dynamic key) async {
    final box = await Hive.openBox<T>('$T');
    await box.deleteAll([key]);
  }
}
