import 'package:platform_device_id/platform_device_id.dart';

Future<String> getDeviceId() async {
  return await PlatformDeviceId.getDeviceId ?? "";
}
