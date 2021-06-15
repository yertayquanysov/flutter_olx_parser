import 'package:olx_parser/repository/jwt_repository.dart';
import 'package:olx_parser/repository/local_database_repository.dart';

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

    if (activationKey.isEmpty) {
      return false;
    }

    if (!_jwtRepository.isValid(activationKey)) {
      return false;
    }

    return true;
  }

  @override
  Future<bool> activateKey(String licenseKey) async {
    final isValidKey = _jwtRepository.isValid(licenseKey);

    print(isValidKey);

    if (!isValidKey) {
      return throw Exception("Ключ дұрыс емес");
    }

    await _localDatabase.saveKey(licenseKey);

    return true;
  }
}
