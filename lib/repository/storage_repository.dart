import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'interface/key_storage_repository.dart';

class StorageRepositoryImpl implements KeyStorageRepository {
  final String key = "eq_key";

  final storage = FlutterSecureStorage();

  @override
  Future<String> getActivationKey() async {
    return await storage.read(key: key) ?? "";
  }

  @override
  Future<void> setActivationKey(String newKey) async {
    await storage.write(key: key, value: newKey);
  }
}
