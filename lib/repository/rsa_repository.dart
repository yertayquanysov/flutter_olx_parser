import 'package:olx_parser/repository/license_repository.dart';

abstract class RsaRepository {
  Future<String> validateLicenseKey(String licenseKey);
}

class RsaRepositoryImpl extends LicenseRepositoryImpl implements RsaRepository {
  @override
  Future<String> validateLicenseKey(String licenseKey) async {
    return "";
  }
}
