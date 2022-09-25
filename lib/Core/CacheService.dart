import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CacheService {
  static Type typeOf<T>() => T;

  static Future<List<T>> getAll<T>() async {
    final box = await Hive.openBox<T>('$T');
    final map = box.toMap();
    final lst = List<T>();
    map.forEach((_, value) {
      lst.add(value);
    });
    print('hive $T ${await Hive.boxExists('$T')}');
    print('get All $T ${lst.length}');
    return lst;
  }

  static Future<void> add<T>(dynamic key, T data) async {
    if (data == null) {
      return;
    }
    final openBoxed = Hive.isBoxOpen('$T');
    final box = openBoxed ? Hive.box<T>('$T') : await Hive.openBox<T>('$T');
    await box.put(key, data);
  }

  static Future<void> edit<T>(dynamic key, T data) async {
    if (data == null) {
      return;
    }
    final openBoxed = Hive.isBoxOpen('$T');
    final box = openBoxed ? Hive.box<T>('$T') : await Hive.openBox<T>('$T');
    await box.put(key, data);
  }

  static Future<T> getByKey<T>(dynamic key) async {
    if (key == null) {
      return null;
    }
    try {
      final box = Hive.box<T>('$T');
      return box.get(key);
    } catch (e) {}
    return null;
  }

  static Future<void> clear<T>() async {
    final openBoxed = Hive.isBoxOpen('$T');
    final box = openBoxed ? Hive.box<T>('$T') : await Hive.openBox<T>('$T');
    await box.clear();
  }

  static Future<void> clearAllData() async {
    await Hive.deleteFromDisk();
  }

  static Future<void> delete<T>(dynamic key) async {
    if (key == null) {
      return;
    }
    final box = Hive.box<T>('$T');
    await box.deleteAll([key]);
  }
}
