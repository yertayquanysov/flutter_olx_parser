import 'package:jaguar_jwt/jaguar_jwt.dart';

abstract class JwtRepository {
  String generateActivationKey(Map<String, String> claims);

  bool isValid(String data);
}

class JwtRepositoryImpl implements JwtRepository {
  final jwtKey = "iuawgdgwadyawd";

  @override
  bool isValid(String token) {
    try {
      verifyJwtHS256Signature(token, jwtKey).validate();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  String generateActivationKey(Map<String, String> claims) {
    final claimSet = JwtClaim(otherClaims: claims);
    return issueJwtHS256(claimSet, jwtKey);
  }
}
