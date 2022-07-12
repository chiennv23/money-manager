// import 'package:hive/hive.dart';

import 'package:hive/hive.dart';

class CacheService {
  static Type typeOf<T>() => T;

  static bool isEnableCache = false;

  static Future<bool> isExists({String boxName}) async {
    if (isEnableCache) {
      final openBox = await Hive.openBox(boxName);
      final length = openBox.length;
      return length != 0;
    } else {
      return false;
    }
  }

  static Future<void> addBoxesList<T>(List<T> items, String boxName) async {
    // print('adding boxes');
    final openBox = await Hive.openBox(boxName);

    for (final item in items) {
      await openBox.add(item);
    }
  }

  static Future<void> addBoxesObj<T>(String boxName, T data) async {
    if (data == null) {
      return;
    }
    final box = await Hive.openBox(boxName);
    await box.put(boxName, data);
  }

  static Future<List<T>> getBoxesList<T>(String boxName) async {
    final boxList = <T>[];

    final openBox = await Hive.openBox(boxName);

    final length = openBox.length;

    for (var i = 0; i < length; i++) {
      boxList.add(openBox.getAt(i));
    }

    return boxList;
  }

  static Future<T> getBoxesObj<T>(String boxName) async {
    final box = await Hive.openBox(boxName);
    return box.get(boxName);
  }

  // static Future<void> clear<T>(String boxName) async {
  //   final box = await Hive.openBox(boxName);
  //   await box.clear();
  // }

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
