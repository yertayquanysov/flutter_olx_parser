import 'package:olx_parser/repository/local_database_repository.dart';
import 'package:platform_device_id/platform_device_id.dart';

abstract class LicenseRepository {
  Future<String> getDeviceId();

  Future<bool> checkLicenseKey();

  Future<bool> activateKey(String licenseKey);
}

class LicenseRepositoryImpl extends LocalDatabaseRepositoryImpl
    implements LicenseRepository {
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

    return true;
  }

  @override
  Future<bool> activateKey(String licenseKey) async {
    await saveKey(licenseKey);

    return true;
  }
}
