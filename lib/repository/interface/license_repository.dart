abstract class LicenseRepository {
  Future<String> getDeviceId();

  Future<bool> checkLicenseKey();
}