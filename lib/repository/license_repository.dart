import 'package:olx_parser/repository/jwt_repository.dart';
import 'package:olx_parser/repository/local_database_repository.dart';

import '../ext.dart';

abstract class LicenseRepository {
  Future<bool> checkLicenseKey();

  Future<bool> activateKey(String licenseKey);
}

class LicenseRepositoryImpl implements LicenseRepository {
  final _localDatabase = LocalDatabaseRepositoryImpl();
  final _jwtRepository = JwtRepositoryImpl();

  @override
  Future<bool> checkLicenseKey() async {
    final activationKey = await _localDatabase.getSavedKey();
    final deviceId = await getDeviceId();

    if (activationKey.isEmpty) {
      return false;
    }

    return false;
  }

  @override
  Future<bool> activateKey(String licenseKey) async {
    if (!_jwtRepository.isValid(licenseKey)) {
      return false;
    }

    await _localDatabase.saveKey(licenseKey);

    return true;
  }
}
