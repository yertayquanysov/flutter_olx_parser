import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:olx_parser/repository/html_parser_repository.dart';
import 'package:olx_parser/repository/olx_repository.dart';

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  final OlxRepository olx = OlxRepository();

  test("test parse product id", () async {
    Map<String?, String> urls = {
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
      "":
          "https://www.olx.kz/kk/obyavlenie/repetitor-matematika-fizika-pomosch-na-ent-kta-kurs-repititor"
    };

    urls.forEach((key, url) {
      var productId = olx.getProductId(url);
      expect(key, productId);
    });
  });

  test("test html data parser", () async {
    final testHtmlFile = await rootBundle.loadString("assets/test_item_data");
    final Document document = parse(testHtmlFile);

    final HtmlParserRepository _htmlParserRepository =
        HtmlParserRepository(document.body!);

    expect("Продам лазерный ч/б принтер HP LaserJet P2055d",
        _htmlParserRepository.getName());

    expect("35 000 тг.", _htmlParserRepository.getPrice());
    expect(
        "https://frankfurt.apollo.olxcdn.com:443/v1/files/p660j0hswb9c3-KZ/image;s=644x461",
        _htmlParserRepository.getImageUrl());
    expect("Алматы, Алмалинский район", _htmlParserRepository.getCityName());

    expect("Компьютерлер » Қосалқы құрылғылар",
        _htmlParserRepository.getCategoryName());

    expect("11  март", _htmlParserRepository.getDate());

    expect(
        "https://www.olx.kz/kk/obyavlenie/prodam-lazernyy-ch-b-printer-hp-laserjet-p2055d-IDh8TjV.html#f9f01ff837;promoted",
        _htmlParserRepository.getAdsLink());
  });

  test("get session data", () async {
    final response = await olx.getSessionData();
    print(response.headers.keys);
  });
}
