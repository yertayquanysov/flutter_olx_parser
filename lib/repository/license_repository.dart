import 'package:olx_parser/repository/storage_repository.dart';
import 'package:platform_device_id/platform_device_id.dart';

abstract class LicenseRepository {
  Future<String> getDeviceId();
  Future<bool> checkLicenseKey();
}

class LicenseRepositoryImpl extends StorageRepositoryImpl
    implements LicenseRepository {


  @override
  Future<String> getDeviceId() async {
    final String? deviceId = await PlatformDeviceId.getDeviceId;
    return deviceId!;
  }

  @override
  Future<bool> checkLicenseKey() async {
    final activationKey = await getActivationKey();

    if (activationKey.isEmpty) {
      return false;
    }

    return true;
  }
}
