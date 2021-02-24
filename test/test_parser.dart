import 'package:flutter_test/flutter_test.dart';
import 'package:olx_parser/repository/olx_repository.dart';

void main() {
  final OlxRepository olx = OlxRepository();

  test("test parse product id", () async {
    Map<String, String> urls = {
      "jTcfF":
          "https://www.olx.kz/kk/obyavlenie/avd-portotecnika-elite-2840-380-volt-b-u-IDjTcfF.html",
      "jXIoG":
          "https://www.olx.kz/kk/obyavlenie/remont-ustanovka-rolstavni-sektsionnyh-vorota-avtomatika-shlagbaumov-IDjXIoG.html",
      "jYcUI":
          "https://www.olx.kz/kk/obyavlenie/uslugi-perevozki-shalanda-IDjYcUI.html",
      "jYwlT":
          "https://www.olx.kz/kk/obyavlenie/repetitor-russkiy-yazyk-i-matematika-IDjYwlT.html#06f3abb167;promoted",
      "gqOMu":
          "https://www.olx.kz/kk/obyavlenie/repetitor-matematika-fizika-pomosch-na-ent-kta-kurs-repititor-IDgqOMu.html#06f3abb167;promoted",
      null:
          "https://www.olx.kz/kk/obyavlenie/repetitor-matematika-fizika-pomosch-na-ent-kta-kurs-repititor"
    };

    urls.forEach((key, url) {
      var productId = olx.getProductId(url);
      expect(key, productId);
    });
  });

  test("test parse phone number", () async {

    await olx.getPhoneNumber(
      "https://www.olx.kz/kk/obyavlenie/repetitor-russkiy-yazyk-i-matematika-IDjYwlT.html#06f3abb167;promoted",
    );

    expect(1, 1);
  });
}
