import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDatabaseRepository {
  Future<String> getSavedKey();

  Future<void> clear();

  Future<void> saveKey(String newKey);
}

class LocalDatabaseRepositoryImpl extends LocalDatabaseRepository {
  final String fieldKey = "key";

  Future<SharedPreferences> getPreferences() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Future<String> getSavedKey() async {
    final _pref = await getPreferences();
    return _pref.getString(fieldKey) ?? "";
  }

  @override
  Future<void> saveKey(String newKey) async {
    final _pref = await getPreferences();
    _pref.setString(fieldKey, newKey);
  }

  @override
  Future<void> clear() async {
    final _pref = await getPreferences();
    _pref.clear();
  }
}
