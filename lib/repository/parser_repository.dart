import 'package:flutter/cupertino.dart';
import 'package:html/parser.dart';
import 'package:olx_parser/model/offer_model.dart';
import 'package:http/http.dart' as http;
import 'package:olx_parser/repository/olx_repository.dart';

class ParserRepository extends OlxRepository {

  Future<List<OfferModel>> parseOffers({@required url}) async {
    final response = await http.get(url);
    final document = parse(response.body);

    var result = document
        .getElementsByClassName("offer-wrapper")
        .map<OfferModel>((e) => OfferModel.formDocument(e))
        .toList();

    return result;
  }
}
