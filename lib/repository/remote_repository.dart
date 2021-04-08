import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:olx_parser/model/license_key.dart';

abstract class RemoteRepository {
  Future<bool> checkLicenseKey(
    String licenseKey,
    String deviceId,
  );
}

class RemoteRepositoryImpl implements RemoteRepository {

  final keysCollection = FirebaseFirestore.instance.collection("keys");

  @override
  Future<bool> checkLicenseKey(
    String licenseKey,
    String deviceId,
  ) async {
    /*final keySnapshot = await keysCollection.doc(licenseKey).get();

    if (!keySnapshot.exists) {
      return false;
    }

    final licenseKey = LicenseKey.fromSnapshot(keySnapshot.data());*/

    return false;
  }
}
