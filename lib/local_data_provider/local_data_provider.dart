import 'package:shared_preferences/shared_preferences.dart';

abstract class IDataBase {
  Future<void> init();

  Future<T> get<T>(String key, T defaultValue);

  Future<void> set<T>(String key, T value);
  Future<void> remove<T>(String key);
}

class LocalDataProvider implements IDataBase {
  late final SharedPreferences _prefs;
  @override
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Future<T> get<T>(String key, T defaultValue) async {
    Object? value;
    try {
      value = _prefs.get(key);
      if (value == null) return defaultValue;
      return value as T;
    } catch (e) {
      return defaultValue;
    }
  }

  @override
  Future<void> set<T>(String key, T value) {
    return  _prefs.setString(key, value as String);
  }
  @override
  Future<void> remove<T>(String key) {
    return _prefs.remove(key);
  }

}
