import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class StorageRepository {
  Future<String> getActivationKey();

  void setActivationKey(String newKey);
}

class StorageRepositoryImpl extends StorageRepository {
  final String key = "eq_key";

  final storage = FlutterSecureStorage();

  @override
  Future<String> getActivationKey() async {
    return await storage.read(key: key) ?? "";
  }

  @override
  void setActivationKey(String newKey) {
    storage.write(key: key, value: newKey);
  }
}
