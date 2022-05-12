/*
* ChieNV 2021
* No Change IF
* */
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageHelper {
  StorageHelper._();

  /// _ChieNV
  static final StorageHelper instance = StorageHelper._();

  final storage = const FlutterSecureStorage();

  Future<Map<String, String>> readAllValues() async {
    final _result = await storage.readAll();
    return _result;
  }

  Future<String> read({@required String key}) async {
    final _result = await storage.read(key: key);
    return _result;
  }

  Future<void> write({@required String key, @required String val}) async {
    await storage.write(key: key, value: val);
  }

  Future<bool> containsKey({@required String key}) async {
    final rs = await storage.containsKey(key: key);
    return rs;
  }

  Future<void> deleteAll() async {
    await storage.deleteAll();
  }

  Future<void> delete({@required String key}) async {
    await storage.delete(key: key);
  }
}

class SharedPreferencesHelper {
  SharedPreferences _prefs;

  SharedPreferencesHelper._();

  static final SharedPreferencesHelper instance = SharedPreferencesHelper._();

  /// _ChieNV.
  ///
  /// *Call init() in main project.
  ///
  /// *Create SharedPreferences.getInstance on global.
  ///
  /// *Content paste: await SharedPreferencesHelper.instance.init();
  Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> setString({@required String key, @required String val}) async {
    return _prefs.setString(key, val);
  }

  Future<void> setDouble({@required String key, @required double val}) async {
    return _prefs.setDouble(key, val);
  }

  Future<void> setBool({@required String key, @required bool val}) async {
    return _prefs.setBool(key, val);
  }

  Future<void> setInt({@required String key, @required int val}) async {
    return _prefs.setInt(key, val);
  }

  Future<void> setStringList(
      {@required String key, @required List<String> val}) async {
    return _prefs.setStringList(key, val);
  }

  String getString({@required String key}) {
    return _prefs.getString(key);
  }

  double getDouble({@required String key}) {
    return _prefs.getDouble(key);
  }

  bool getBool({@required String key}) {
    return _prefs.getBool(key);
  }

  int getInt({@required String key}) {
    return _prefs.getInt(key);
  }

  Object getObj({@required String key}) {
    return _prefs.get(key);
  }

  List<String> getStringList({@required String key}) {
    return _prefs.getStringList(key);
  }

  Set<String> getListKeys() {
    return _prefs.getKeys();
  }

  Future<bool> removeKey({@required String key}) {
    return _prefs.remove(key);
  }

  Future<bool> clearAllKeys() {
    return _prefs.clear();
  }

  bool containsKey({@required String key}) {
    return _prefs.containsKey(key);
  }

  Future<void> reloadAll() {
    return _prefs.reload();
  }

  static SharedPreferencesHelper fromJson(decode) {}
}
