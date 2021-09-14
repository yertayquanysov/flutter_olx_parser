import 'package:olx_parser/repository/storage_repository.dart';
import 'package:platform_device_id/platform_device_id.dart';

import 'interface/license_repository.dart';

class LicenseRepositoryImpl extends StorageRepositoryImpl
    implements LicenseRepository {


  @override
  Future<String> getDeviceId() async {
    try {
      final String? deviceId = await PlatformDeviceId.getDeviceId;
      return deviceId!;
    } catch (e) {
      return "";
    }
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
