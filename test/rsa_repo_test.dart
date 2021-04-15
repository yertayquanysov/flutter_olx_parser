import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:olx_parser/repository/rsa_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final RsaRepository _rsaRepository = RsaRepositoryImpl();

  test("test validate key", () async {
    final result = _rsaRepository.validateLicenseKey(
        "Lxgi97K+1UYRmCn43ZT5v2Wk/Aa6NDiOr8KffMrc9/yoEkYo8jf3mrVzLcxANi6qF/Jv2GLm2osHuxMTrAl1aV1e9Spi/LGbJLwfX0dYtQnYY/2x+8mBEyK/hJEBt02CegqEYyGkA0GQs989mhLhAnk4z164/xCi/RYDXID+MrUEaPQXk4P56fIgTxqGgOq4qf/GxYAjEMrVnaVU+tWXxx7trmZCf2RuCnZaHzAUysyBNhxc58aPppkrQAOTfv9FEGuSChLJEBInnQLKv3legsxHkl2SNGbvb+Ojc06kEsp6+iehRAe6UKjgiWcu6kmlpsHT8CxJ0Xw3aKSIjU2/Tw==");

    print(result);
  });
}
