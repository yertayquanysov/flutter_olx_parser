import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class LocalDatabaseRepository {
  Future<String> getSavedKey();

  void saveKey(String newKey);
}

class LocalDatabaseRepositoryImpl extends LocalDatabaseRepository {

  final String key = "eq_key";

  final storage = FlutterSecureStorage();

  @override
  Future<String> getSavedKey() async {
    return await storage.read(key: key) ?? "";
  }

  @override
  Future<void> saveKey(String newKey) async{
    await storage.write(key: key, value: newKey);
  }
}
