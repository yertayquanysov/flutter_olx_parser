import 'package:html/dom.dart' as dataHtml;
import 'package:olx_parser/repository/html_parser_repository.dart';
import 'package:olx_parser/repository/olx_repository.dart';

class ParsedData {
  final String name;
  final String price;
  final String phoneNumber;
  final String offerUrl;
  final String date;
  final String city;
  final String imageUrl;
  final String sellerName;
  final String categoryName;

  ParsedData({
    this.name,
    this.price,
    this.phoneNumber,
    this.city,
    this.offerUrl,
    this.date,
    this.imageUrl,
    this.sellerName,
    this.categoryName,
  });

  Map<String, Object> toDocument() {
    return {
      "name": name,
      "price": price,
      "phoneNumber": phoneNumber,
      "offerUrl": offerUrl,
      "date": date,
      "city": city,
      "imageUrl": imageUrl,
      "sellerName": sellerName,
      "categoryName": categoryName,
    };
  }

  static formDocument(dataHtml.Element data) async {

    final _parser = HtmlParserRepository(data);
    final _olxParser = OlxRepository();

    final phoneNumber = await _olxParser.getPhoneNumber(_parser.getAdsLink());

    try {
      return ParsedData(
        name: _parser.getName(),
        imageUrl: _parser.getImageUrl(),
        price: _parser.getPrice(),
        city: _parser.getCityName(),
        categoryName: _parser.getCategoryName(),
        phoneNumber: phoneNumber,
        offerUrl: _parser.getAdsLink(),
      );
    } catch (e) {
      return ParsedData(name: e.toString(), imageUrl: "");
    }
  }
}
