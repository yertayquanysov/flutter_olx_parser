import 'package:olx_parser/repository/firestore_repository.dart';
import 'package:olx_parser/repository/local_database_repository.dart';
import 'package:platform_device_id/platform_device_id.dart';

abstract class LicenseRepository {
  Future<String> getDeviceId();

  Future<bool> checkLicenseKey();

  Future<bool> activateKey(String licenseKey);
}

class LicenseRepositoryImpl extends LocalDatabaseRepositoryImpl
    implements LicenseRepository {
  final FirebaseRepository _firebaseRepository = FirebaseRepositoryImpl();

  @override
  Future<String> getDeviceId() async {
    final String? deviceId = await PlatformDeviceId.getDeviceId;
    return deviceId!;
  }

  @override
  Future<bool> checkLicenseKey() async {
    final activationKey = await getSavedKey();
    final deviceId = await getDeviceId();

    if (activationKey.isEmpty) {
      return false;
    }

    final bool isValidKey = await _firebaseRepository.validateKey(
      deviceId: deviceId,
      licenseKey: activationKey,
    );

    return isValidKey;
  }

  @override
  Future<bool> activateKey(String licenseKey) async {
    await saveKey(licenseKey);
    return await _firebaseRepository.activateKey(
      licenseKey,
      await getDeviceId(),
    );
  }
}
