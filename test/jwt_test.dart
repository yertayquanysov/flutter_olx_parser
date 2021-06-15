import 'package:flutter_test/flutter_test.dart';
import 'package:olx_parser/repository/jwt_repository.dart';

void main() {
  final jwtRepo = JwtRepositoryImpl();

  test("test generate activation key", () {
    final jwtToken = jwtRepo.generateActivationKey({
      "name": "Ertai",
    });

    print(jwtToken);

    expect(true, jwtToken.isNotEmpty);
  });

  test("test success validate activation key", () {
    final jwtToken = jwtRepo.generateActivationKey({
      "name": "Ertai",
    });

    print(jwtToken);

    expect(true, jwtRepo.isValid(jwtToken));
  });

  test("test failed validate activation key", () {
    final jwtToken = "iouawghdigawydgawyudgwua";
    expect(false, jwtRepo.isValid(jwtToken));
  });
}
