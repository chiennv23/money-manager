// // import 'package:hive/hive.dart';

// import 'package:hive/hive.dart';

// class CacheService {
//   static bool isEnableCache = false;
//   static Future<bool> isExists({String boxName}) async {
//     if (isEnableCache) {
//       final openBox = await Hive.openBox(boxName);
//       final length = openBox.length;
//       return length != 0;
//     } else {
//       return false;
//     }
//   }

//   static Future<void> addBoxesList<T>(List<T> items, String boxName) async {
//     // print('adding boxes');
//     final openBox = await Hive.openBox(boxName);

//     for (final item in items) {
//       await openBox.add(item);
//     }
//   }

//   static Future<void> addBoxesObj<T>(String boxName, T data) async {
//     if (data == null) {
//       return;
//     }
//     final box = await Hive.openBox(boxName);
//     await box.put(boxName, data);
//   }

//   static Future<List<T>> getBoxesList<T>(String boxName) async {
//     final boxList = <T>[];

//     final openBox = await Hive.openBox(boxName);

//     final length = openBox.length;

//     for (var i = 0; i < length; i++) {
//       boxList.add(openBox.getAt(i));
//     }

//     return boxList;
//   }

//   static Future<T> getBoxesObj<T>(String boxName) async {
//     final box = await Hive.openBox(boxName);
//     return box.get(boxName);
//   }

//   static Future<void> clear<T>(String boxName) async {
//     final box = await Hive.openBox(boxName);
//     await box.clear();
//   }
// }
