import 'package:platform_device_id/platform_device_id.dart';

abstract class LicenceRepository {
  Future<String> getDeviceId();
}

class LicenseRepositoryImpl implements LicenceRepository {
  @override
  Future<String> getDeviceId() async {

    final String? deviceId = await PlatformDeviceId.getDeviceId;

    print("Device Id: " + deviceId.toString());

    return deviceId!;
  }
}
