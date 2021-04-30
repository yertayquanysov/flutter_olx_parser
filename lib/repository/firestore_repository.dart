import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:olx_parser/exceptions/license_exception.dart';

abstract class FirebaseRepository {
  Future<DocumentSnapshot> getKey(String key);

  Future<bool> validateKey({
    required String deviceId,
    required String licenseKey,
  });

  Future<bool> activateKey(String licenseKey, String deviceId);
}

class FirebaseRepositoryImpl implements FirebaseRepository {

  final _keyCollection = FirebaseFirestore.instance.collection("keys_v1");

  @override
  Future<DocumentSnapshot> getKey(String key) async {
    return await _keyCollection.doc(key).get();
  }

  @override
  Future<bool> activateKey(String licenseKey, String deviceId) async {

    print("Activating...");

    final key = await getKey(licenseKey);

    if (!key.exists) {
      return throw InValidLicenseKeyException();
    }

    if (key.data()!.containsKey("deviceId")) {
      return throw LicenseKeyActivatedException();
    }

    await key.reference.update({
      "deviceId": deviceId,
    });

    return true;
  }

  @override
  Future<bool> validateKey({
    required String deviceId,
    required String licenseKey,
  }) async {
    final key = await getKey(licenseKey);

    if (!key.exists) {
      return false;
    }

    return key.get("deviceId") == deviceId;
  }
}
